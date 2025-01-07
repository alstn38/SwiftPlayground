//
//  PopularCityViewController.swift
//  MSTravel
//
//  Created by 강민수 on 1/7/25.
//

import UIKit

final class PopularCityViewController: UIViewController {
    
    @IBOutlet private var countrySegmentedControl: UISegmentedControl!
    @IBOutlet private var cityCollectionView: UICollectionView!
    private var allCountryCategory: CountryCategory = .all
    private let originalCityArray: [City] = CityInfo().city
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigation()
        setupView()
        setupCollectionView()
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
        layout.itemSize = CGSize(width: itemLength, height: itemLength)
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 20
        layout.minimumInteritemSpacing = minimumInteritemSpacing
        layout.sectionInset = UIEdgeInsets(top: 8, left: horizontalSpace, bottom: 8, right: horizontalSpace)
        
        cityCollectionView.collectionViewLayout = layout
    }
}

extension PopularCityViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    /// collectionView의 Section별 Item의 개수를 반환하는 메서드
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return originalCityArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let item = collectionView.dequeueReusableCell(
            withReuseIdentifier: PopularCityCollectionViewCell.identifier,
            for: indexPath
        ) as? PopularCityCollectionViewCell else { return UICollectionViewCell() }
        
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
    }
}
