//
//  SearchViewController.swift
//  MSShopping
//
//  Created by 강민수 on 1/15/25.
//

import SnapKit
import UIKit

final class SearchViewController: UIViewController {
    
    private let shoppingSearchBar: UISearchBar = {
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
    
    private let searchWarningLabel: UILabel = {
        let label = UILabel()
        label.text = "최소 2글자 이상 입력해주세요."
        label.isHidden = true
        label.textColor = .systemRed
        label.font = .systemFont(ofSize: 12, weight: .medium)
        return label
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    private func setupView() {
        view.backgroundColor = .black
        
        setupNavigation()
        setupHierarchy()
        setupLayout()
        setupSearchBar()
    }
    
    private func setupNavigation() {
        navigationItem.title = "MS의 쇼핑쇼핑"
    }
    
    private func setupHierarchy() {
        [shoppingSearchBar, searchWarningLabel, shoppingImageView, shoppingMessageLabel].forEach {
            view.addSubview($0)
        }
    }
    
    private func setupLayout() {
        shoppingSearchBar.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(10)
            $0.height.equalTo(38)
        }
        
        searchWarningLabel.snp.makeConstraints {
            $0.top.equalTo(shoppingSearchBar.snp.bottom).offset(5)
            $0.leading.equalTo(shoppingSearchBar).offset(15)
        }
        
        shoppingImageView.snp.makeConstraints {
            $0.center.equalTo(view)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(40)
            $0.height.equalTo(shoppingImageView.snp.width)
        }
        
        shoppingMessageLabel.snp.makeConstraints {
            $0.top.equalTo(shoppingImageView.snp.bottom).offset(20)
            $0.centerX.equalTo(view)
        }
    }
    
    private func setupSearchBar() {
        shoppingSearchBar.delegate = self
    }
}

// MARK: - UISearchBarDelegate
extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let isLargerThanTwoLetters: Bool = searchBar.text?.count ?? 0 >= 2
        searchWarningLabel.isHidden = isLargerThanTwoLetters
        
        guard isLargerThanTwoLetters else { return }
        let searchResultViewController = SearchResultViewController(searchedText: searchBar.text ?? "검색결과")
        navigationController?.pushViewController(searchResultViewController, animated: true)
    }
}
