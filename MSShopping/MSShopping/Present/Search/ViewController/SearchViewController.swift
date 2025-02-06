//
//  SearchViewController.swift
//  MSShopping
//
//  Created by 강민수 on 1/15/25.
//

import UIKit

final class SearchViewController: UIViewController {
    
    private let searchView = SearchView()
    private let viewModel: SearchViewModel
    private let input: SearchViewModel.Input
    private let output: SearchViewModel.Output
    
    private let shoppingSearchTextDidChangeSubject: Observable<String?> = Observable(nil)
    private let searchButtonDidClickSubject: Observable<Void> = Observable(())
    
    override func loadView() {
        view = searchView
    }
    
    init(viewModel: SearchViewModel) {
        self.viewModel = viewModel
        self.input = SearchViewModel.Input(
            shoppingSearchTextDidChange: shoppingSearchTextDidChangeSubject,
            searchButtonDidClick: searchButtonDidClickSubject
        )
        
        self.output = viewModel.transform(from: input)
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBind()
        setupView()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    private func setupBind() {
        output.searchWarningLabelText.bind { [weak self] text in
            guard let self else { return }
            searchView.searchWarningLabel.text = text
        }
        
        output.pushToResultViewController.bind { [weak self] searchedText in
            guard let self else { return }
            let searchResultViewController = SearchResultViewController(searchedText: searchedText)
            navigationController?.pushViewController(searchResultViewController, animated: true)
        }
        
        output.alertError.bind { [weak self] alertText in
            guard let self else { return }
            presentDefaultAlert(alertTitle: alertText)
        }
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
        searchView.shoppingSearchBar.searchTextField.addTarget(
            self,
            action: #selector(shoppingSearchTextFieldDidEditingChange),
            for: .editingChanged
        )
    }
    
    @objc private func shoppingSearchTextFieldDidEditingChange(_ sender: UISearchTextField) {
        shoppingSearchTextDidChangeSubject.send(sender.text)
    }
}

// MARK: - UISearchBarDelegate
extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchButtonDidClickSubject.send(())
    }
}
