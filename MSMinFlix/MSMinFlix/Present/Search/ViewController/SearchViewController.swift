//
//  SearchViewController.swift
//  MSMinFlix
//
//  Created by 강민수 on 1/13/25.
//

import Alamofire
import SnapKit
import UIKit

final class SearchViewController: UIViewController {
    
    private var dailyBoxOfficeArray: [DailyBoxOfficeList] = [] {
        didSet {
            movieCollectionView.reloadData()
        }
    }
    
    private let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_KO")
        dateFormatter.dateFormat = "yyyyMMdd"
        return dateFormatter
    }()
    
    private let yesterday: Date? = {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        let yesterDay = calendar.date(byAdding: .day, value: -1, to: today)
        
        return yesterDay
    }()
    
    private let searchTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .none
        textField.setPlaceholder(placeholder: "검색어를 입력해주세요", color: .systemGray4)
        textField.returnKeyType = .search
        textField.textColor = .white
        textField.tintColor = .clear
        
        return textField
    }()
    
    private let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.locale = Locale(identifier: "ko_KR")
        
        return datePicker
    }()
    
    private let searchLineView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        
        return view
    }()
    
    private let searchButton: UIButton = {
        let button = UIButton()
        button.setTitle("검색", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        
        return button
    }()
    
    private let movieCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 5
        let edgeInsets: CGFloat = 20
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width - edgeInsets * 2, height: 40)
        layout.sectionInset = UIEdgeInsets(top: 15, left: edgeInsets, bottom: 15, right: edgeInsets)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .black
        
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupDatePicker()
    }
    
    private func setupView() {
        view.backgroundColor = .black
        
        setupHierarchy()
        setupLayout()
        setupCollectionView()
        
        guard let yesterday else { return }
        getBoxOfficeMovieRank(date: yesterday)
    }
    
    private func setupHierarchy() {
        [searchTextField, searchLineView, searchButton, movieCollectionView].forEach {
            view.addSubview($0)
        }
    }
    
    private func setupLayout() {
        searchTextField.snp.makeConstraints {
            $0.top.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).inset(100)
            $0.height.equalTo(40)
        }
        
        searchLineView.snp.makeConstraints {
            $0.top.equalTo(searchTextField.snp.bottom)
            $0.horizontalEdges.equalTo(searchTextField)
            $0.height.equalTo(1)
        }
        
        searchButton.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.height.equalTo(40)
            $0.width.equalTo(60)
        }
        
        movieCollectionView.snp.makeConstraints {
            $0.top.equalTo(searchLineView.snp.bottom).offset(2)
            $0.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func setupCollectionView() {
        movieCollectionView.delegate = self
        movieCollectionView.dataSource = self
        movieCollectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: MovieCollectionViewCell.identifier)
    }
    
    private func setupDatePicker() {
        searchTextField.inputView = datePicker
        datePicker.maximumDate = yesterday
        datePicker.addTarget(self, action: #selector(dateValueDidChange), for: .valueChanged)
    }
    
    private func getBoxOfficeMovieRank(date: Date) {
        guard let key = Bundle.main.apiKey else { return }
        let targetDate = dateFormatter.string(from: date)
        let url = "http://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=\(key)&targetDt=\(targetDate)"
        
        AF.request(url, method: .get).responseDecodable(of: MovieResult.self) { [weak self] response in
            switch response.result {
            case .success(let value):
                self?.dailyBoxOfficeArray = value.boxOfficeResult.dailyBoxOfficeList
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    @objc private func dateValueDidChange(_ sender: UIDatePicker) {
        let calendar = Calendar.current
        let selectComponents = calendar.dateComponents([.year, .month, .day], from: sender.date)
        getBoxOfficeMovieRank(date: sender.date)
        guard let year = selectComponents.year else { return }
        guard let month = selectComponents.month else { return }
        guard let day = selectComponents.day else { return }
        searchTextField.text = "\(year)년 \(month)월 \(day)일"
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dailyBoxOfficeArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: MovieCollectionViewCell.identifier,
            for: indexPath
        ) as? MovieCollectionViewCell else { return UICollectionViewCell() }
        
        cell.configureCell(dailyBoxOfficeArray[indexPath.item])
        
        return cell
    }
}
