//
//  SearchResultViewController.swift
//  MSShopping
//
//  Created by 강민수 on 1/15/25.
//

import Alamofire
import SnapKit
import UIKit

final class SearchResultViewController: UIViewController {
    
    private var selectedFilterButtonType: FilterButton.FilterButtonType = .accuracy
    private var searchedText: String
    private var productItemArray: [Item] = [] {
        didSet {
            productCollectionView.reloadData()
        }
    }
    
    private let searchTotalCountLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGreen
        label.font = .systemFont(ofSize: 12, weight: .bold)
        return label
    }()
    
    private let filterStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.spacing = 10
        stackView.alignment = .leading
        return stackView
    }()
    
    private let filterButtonArray: [FilterButton] = {
        let button = FilterButton.FilterButtonType.allCases.map {
            let button = FilterButton(type: $0)
            button.tag = $0.rawValue
            return button
        }
        
        button[FilterButton.FilterButtonType.accuracy.rawValue].isSelected = true
        return button
    }()
    
    private let productCollectionView: UICollectionView = {
        let screenWidth = UIScreen.main.bounds.width
        let spacing: CGFloat = 20
        let cellWidth = (screenWidth - spacing * 3) / 2
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 30
        layout.minimumInteritemSpacing = spacing
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.itemSize = CGSize(width: cellWidth, height: cellWidth + 60)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .black
        return collectionView
    }()
    
    init(searchedText: String) {
        self.searchedText = searchedText
        super.init(nibName: nil, bundle: nil)
        navigationItem.title = searchedText
    }
    
    required init?(coder: NSCoder) {
        self.searchedText = ""
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        getProductResult()
    }
    
    private func setupView() {
        view.backgroundColor = .black
        
        setupHierarchy()
        setupLayout()
        setupCollectionView()
        addTargetButton()
    }
    
    private func setupHierarchy() {
        [searchTotalCountLabel, filterStackView, productCollectionView].forEach {
            view.addSubview($0)
        }
        
        filterButtonArray.forEach {
            filterStackView.addArrangedSubview($0)
        }
    }
    
    private func setupLayout() {
        searchTotalCountLabel.snp.makeConstraints {
            $0.top.leading.equalTo(view.safeAreaLayoutGuide).offset(10)
        }
        
        filterStackView.snp.makeConstraints {
            $0.top.equalTo(searchTotalCountLabel.snp.bottom).offset(10)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(10)
        }
        
        productCollectionView.snp.makeConstraints {
            $0.top.equalTo(filterStackView.snp.bottom).offset(5)
            $0.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func addTargetButton() {
        filterButtonArray.forEach {
            $0.addTarget(self, action: #selector(filterButtonDidTap), for: .touchUpInside)
        }
    }
    
    private func setupCollectionView() {
        productCollectionView.delegate = self
        productCollectionView.dataSource = self
        productCollectionView.register(ProductCollectionViewCell.self, forCellWithReuseIdentifier: ProductCollectionViewCell.identifier)
    }
    
    private func getProductResult() {
        let encodeString = searchedText.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let url = Bundle.main.mainURL + "?query=\(encodeString)&display=100&sort=\(selectedFilterButtonType.query)"
        let header: HTTPHeaders = [
            "X-Naver-Client-Id": Bundle.main.clientID,
            "X-Naver-Client-Secret": Bundle.main.apiKey
        ]
        
        AF.request(url, method: .get, headers: header)
            .responseDecodable(of: Product.self) { [weak self] response in
            switch response.result {
            case .success(let value):
                self?.searchTotalCountLabel.text = "\(value.total.formatted())개의 검색 결과"
                self?.productItemArray = value.items
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    @objc private func filterButtonDidTap(_ sender: UIButton) {
        selectedFilterButtonType = FilterButton.FilterButtonType(rawValue: sender.tag) ?? .accuracy
        filterButtonArray.forEach { $0.isSelected = false }
        sender.isSelected = true
        getProductResult()
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension SearchResultViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productItemArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ProductCollectionViewCell.identifier,
            for: indexPath
        ) as? ProductCollectionViewCell else { return UICollectionViewCell() }
        cell.configureCell(productItemArray[indexPath.item])
        
        return cell
    }
}
