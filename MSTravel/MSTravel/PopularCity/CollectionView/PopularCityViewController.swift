//
//  PopularCityViewController.swift
//  MSTravel
//
//  Created by 강민수 on 1/7/25.
//

import UIKit

final class PopularCityViewController: UIViewController {
    
    @IBOutlet private var citySearchBar: UISearchBar!
    @IBOutlet private var countrySegmentedControl: UISegmentedControl!
    @IBOutlet private var cityCollectionView: UICollectionView!
    
    private var filteredCityArray: [City] = [] {
        didSet {
            cityCollectionView.reloadData()
        }
    }
    
    private var searchedText: String = "" {
        didSet {
            filteredCityArray = selectedCountryCategory.originalCityArray.filter { $0.hasKeyword(searchedText) }
        }
    }
    
    private var selectedCountryCategory: CountryCategory = .all {
        didSet {
            filteredCityArray = selectedCountryCategory.originalCityArray.filter { $0.hasKeyword(searchedText) }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigation()
        setupView()
        setupCollectionView()
        countrySegmentValueDidChange(countrySegmentedControl)
    }
    
    /// 네비게이션을 설정하는 메서드
    private func setupNavigation() {
        navigationItem.title = "인기 도시"
        // navigationItem.titleView에 넣으려고 시도했지만, title과 같이 넣을 수 없다는 사실 발견
    }
    
    /// 뷰의 속성을 설정하는 메서드
    private func setupView() {
        countrySegmentedControl.setTitle(
            CountryCategory.all.title,
            forSegmentAt: CountryCategory.all.rawValue
        )
        countrySegmentedControl.setTitle(
            CountryCategory.domestic.title,
            forSegmentAt: CountryCategory.domestic.rawValue
        )
        countrySegmentedControl.setTitle(
            CountryCategory.overseas.title,
            forSegmentAt: CountryCategory.overseas.rawValue
        )
    }
    
    private func setupCollectionView() {
        cityCollectionView.delegate = self
        cityCollectionView.dataSource = self
        
        let xib = UINib(nibName: PopularCityCollectionViewCell.identifier, bundle: nil)
        cityCollectionView.register(xib, forCellWithReuseIdentifier: PopularCityCollectionViewCell.identifier)
        
        let screenWidth: CGFloat = UIScreen.main.bounds.width
        let horizontalSpace: CGFloat = 20
        let minimumInteritemSpacing: CGFloat = 20
        let rowItemCount = 2
        let itemLength = (screenWidth - (horizontalSpace * 2) - minimumInteritemSpacing) / CGFloat(rowItemCount)
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: itemLength, height: itemLength / 4 * 6)
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 20
        layout.minimumInteritemSpacing = minimumInteritemSpacing
        layout.sectionInset = UIEdgeInsets(top: 8, left: horizontalSpace, bottom: 8, right: horizontalSpace)
        
        cityCollectionView.collectionViewLayout = layout
    }
    
    /// 국가 선택 Segment 값이 변경되었을 때 호출되는 메서드
    @IBAction private func countrySegmentValueDidChange(_ sender: UISegmentedControl) {
        selectedCountryCategory = CountryCategory(rawValue: sender.selectedSegmentIndex)
    }
}

extension PopularCityViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    /// collectionView의 Section별 Item의 개수를 반환하는 메서드
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredCityArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let item = collectionView.dequeueReusableCell(
            withReuseIdentifier: PopularCityCollectionViewCell.identifier,
            for: indexPath
        ) as? PopularCityCollectionViewCell else { return UICollectionViewCell() }
        item.configureCell(filteredCityArray[indexPath.row])
        
        return item
    }
}

extension PopularCityViewController {
    
    enum CountryCategory: Int {
        case all
        case domestic
        case overseas
        
        init(rawValue: Int) {
            switch rawValue {
            case 0: self = .all
            case 1: self = .domestic
            case 2: self = .overseas
            default: self = .all
            }
        }
        
        var title: String {
            switch self {
            case .all:
                return "모두"
            case .domestic:
                return "국내"
            case .overseas:
                return "해외"
            }
        }
        
        var originalCityArray: [City] {
            switch self {
            case .all:
                return CityInfo().city
            case .domestic:
                return CityInfo().city.filter { $0.domestic_travel }
            case .overseas:
                return CityInfo().city.filter { !$0.domestic_travel }
            }
        }
    }
}
