//
//  SearchViewController.swift
//  MSShopping
//
//  Created by 강민수 on 1/15/25.
//

import UIKit

final class SearchViewController: UIViewController {
    
    private let shoppingSearchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "브랜드, 상품, 프로필, 태그 등"
        return searchBar
    }()
    
    private let shoppingImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(resource: .shoppingMan)
        imageView.contentMode = .scaleToFill
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    private func setupView() {
        view.backgroundColor = .black
        
        setupNavigation()
        setupHierarchy()
        setupLayout()
    }
    
    private func setupNavigation() {
        navigationItem.title = "MS의 쇼핑쇼핑"
    }
    
    private func setupHierarchy() {
        
    }
    
    private func setupLayout() {
        
    }
}
