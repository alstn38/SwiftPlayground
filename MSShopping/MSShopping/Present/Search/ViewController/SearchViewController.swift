//
//  SearchViewController.swift
//  MSShopping
//
//  Created by 강민수 on 1/15/25.
//

import UIKit

final class SearchViewController: UIViewController {
    
    private let searchView = SearchView()
    
    override func loadView() {
        view = searchView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigation()
        setupSearchBar()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    private func setupView() {
        
        setupNavigation()
        setupSearchBar()
    }
    
    private func setupNavigation() {
        navigationItem.title = "MS의 쇼핑쇼핑"
    }
    
    private func setupSearchBar() {
        searchView.shoppingSearchBar.delegate = self
    }
}

// MARK: - UISearchBarDelegate
extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let isLargerThanTwoLetters: Bool = searchBar.text?.count ?? 0 >= 2
        searchView.searchWarningLabel.isHidden = isLargerThanTwoLetters
        
        guard isLargerThanTwoLetters else { return }
        guard let searchedText = searchBar.text else { return }
        let searchResultViewController = SearchResultViewController(searchedText: searchedText)
        navigationController?.pushViewController(searchResultViewController, animated: true)
    }
}
