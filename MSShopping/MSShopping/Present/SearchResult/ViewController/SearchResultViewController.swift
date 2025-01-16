//
//  SearchResultViewController.swift
//  MSShopping
//
//  Created by 강민수 on 1/15/25.
//

import Alamofire
import UIKit

final class SearchResultViewController: UIViewController {
    
    private let searchResultView = SearchResultView()
    private var selectedFilterButtonType: FilterButton.FilterButtonType = .accuracy
    private var startPage: Int = 1
    private var searchedText: String
    private var productTotalCount: Int?
    private var productItemArray: [Item] = [] {
        didSet {
            searchResultView.productCollectionView.reloadData()
        }
    }
    
    init(searchedText: String) {
        self.searchedText = searchedText
        super.init(nibName: nil, bundle: nil)
        navigationItem.title = searchedText
    }
    
    required init?(coder: NSCoder) {
        self.searchedText = ""
        super.init(coder: coder)
    }
    
    override func loadView() {
        view = searchResultView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addTargetButton()
        setupCollectionView()
        getProductResult()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        searchResultView.indicatorView.startAnimating()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        searchResultView.indicatorView.stopAnimating()
    }
    
    private func addTargetButton() {
        searchResultView.filterButtonArray.forEach {
            $0.addTarget(self, action: #selector(filterButtonDidTap), for: .touchUpInside)
        }
    }
    
    private func setupCollectionView() {
        searchResultView.productCollectionView.delegate = self
        searchResultView.productCollectionView.dataSource = self
        searchResultView.productCollectionView.register(
            ProductCollectionViewCell.self,
            forCellWithReuseIdentifier: ProductCollectionViewCell.identifier
        )
    }
    
    private func getProductResult() {
        searchResultView.indicatorView.startAnimating()
        let encodeString = searchedText.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let url = Bundle.main.mainURL + "?query=\(encodeString)&display=30&sort=\(selectedFilterButtonType.query)&start=\(startPage)"
        let header: HTTPHeaders = [
            "X-Naver-Client-Id": Bundle.main.clientID,
            "X-Naver-Client-Secret": Bundle.main.apiKey
        ]
        
        AF.request(url, method: .get, headers: header)
            .responseDecodable(of: Product.self) { [weak self] response in
            switch response.result {
            case .success(let value):
                self?.productTotalCount = value.total
                self?.searchResultView.searchTotalCountLabel.text = "\(value.total.formatted())개의 검색 결과"
                self?.productItemArray.append(contentsOf: value.items)
                self?.searchResultView.indicatorView.stopAnimating()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    @objc private func filterButtonDidTap(_ sender: UIButton) {
        searchResultView.productCollectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: false)
        productItemArray = []
        startPage = 1
        selectedFilterButtonType = FilterButton.FilterButtonType(rawValue: sender.tag) ?? .accuracy
        searchResultView.filterButtonArray.forEach { $0.isSelected = false }
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
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let productTotalCount,
                startPage <= 1000 && productItemArray.count < productTotalCount else { return }
        let rowItemCount: Int = 2
        if productItemArray.count - (rowItemCount * 1) - 1  == indexPath.item {
            startPage += 1
            getProductResult()
        }
    }
}
