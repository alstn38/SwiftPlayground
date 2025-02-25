//
//  SearchView.swift
//  MSShopping
//
//  Created by 강민수 on 1/16/25.
//

import SnapKit
import UIKit

final class SearchView: BaseView {
    
    let shoppingSearchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.searchBarStyle = .minimal
        searchBar.searchTextField.leftView?.tintColor = .gray
        searchBar.searchTextField.textColor = .white
        searchBar.searchTextField.attributedPlaceholder = NSAttributedString(
            string: "브랜드, 상품, 프로필, 태그 등",
            attributes: [.foregroundColor: UIColor.gray]
        )
        return searchBar
    }()
    
    private let shoppingImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(resource: .personShopping)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let shoppingMessageLabel: UILabel = {
        let label = UILabel()
        label.text = "원하는 모든 쇼핑을 MS와 함께"
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    override func setupView() {
        backgroundColor = .black
    }
    
    override func setupHierarchy() {
        [shoppingSearchBar, shoppingImageView, shoppingMessageLabel].forEach {
            addSubview($0)
        }
    }
    
    override func setupLayout() {
        shoppingSearchBar.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).offset(10)
            $0.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(10)
            $0.height.equalTo(38)
        }
        
        shoppingImageView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(40)
            $0.height.equalTo(shoppingImageView.snp.width)
        }
        
        shoppingMessageLabel.snp.makeConstraints {
            $0.top.equalTo(shoppingImageView.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
        }
    }
}
