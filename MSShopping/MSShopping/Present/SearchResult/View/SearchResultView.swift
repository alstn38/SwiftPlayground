//
//  SearchResultView.swift
//  MSShopping
//
//  Created by 강민수 on 1/16/25.
//

import SnapKit
import UIKit

final class SearchResultView: BaseView {
    
    let searchTotalCountLabel: UILabel = {
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
    
    let filterButtonArray: [FilterButton] = {
        let button = FilterButton.FilterButtonType.allCases.map {
            let button = FilterButton(type: $0)
            button.tag = $0.rawValue
            return button
        }
        
        button[FilterButton.FilterButtonType.accuracy.rawValue].isSelected = true
        return button
    }()
    
    let productCollectionView: UICollectionView = {
        let layout = BaseCollectionViewFlowLayout(
            cellCountOfRow: 2,
            insetSize: 20,
            minimumSpacing: 30,
            heightMultiply: 1.4
        )
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .black
        collectionView.showsVerticalScrollIndicator = true
        collectionView.indicatorStyle = .white
        return collectionView
    }()
    
    let indicatorView: UIActivityIndicatorView = {
        let indicatorView = UIActivityIndicatorView()
        indicatorView.style = .medium
        indicatorView.color = .white
        indicatorView.hidesWhenStopped = true
        return indicatorView
    }()
    
    override func setupView() {
        backgroundColor = .black
        
        setupHierarchy()
        setupLayout()
    }
    
    override func setupHierarchy() {
        [searchTotalCountLabel, filterStackView, productCollectionView, indicatorView].forEach {
            addSubview($0)
        }
        
        filterButtonArray.forEach {
            filterStackView.addArrangedSubview($0)
        }
    }
    
    override func setupLayout() {
        searchTotalCountLabel.snp.makeConstraints {
            $0.top.leading.equalTo(safeAreaLayoutGuide).offset(10)
        }
        
        filterStackView.snp.makeConstraints {
            $0.top.equalTo(searchTotalCountLabel.snp.bottom).offset(10)
            $0.leading.equalTo(safeAreaLayoutGuide).offset(10)
        }
        
        productCollectionView.snp.makeConstraints {
            $0.top.equalTo(filterStackView.snp.bottom).offset(5)
            $0.horizontalEdges.bottom.equalTo(safeAreaLayoutGuide)
        }
        
        indicatorView.snp.makeConstraints {
            $0.center.equalTo(productCollectionView)
        }
    }
}
