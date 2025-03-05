//
//  SearchViewController.swift
//  MSShopping
//
//  Created by 강민수 on 1/15/25.
//

import UIKit
import RxSwift
import RxCocoa

final class SearchViewController: UIViewController {
    
    private let searchView = SearchView()
    private let favoriteButton = UIBarButtonItem()
    private let wishlistButton = UIBarButtonItem()
    private let viewModel: SearchViewModel
    private let disposeBag = DisposeBag()
    
    override func loadView() {
        view = searchView
    }
    
    init(viewModel: SearchViewModel) {
        self.viewModel = viewModel
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
        let input = SearchViewModel.Input(
            favoriteButtonDidTap: favoriteButton.rx.tap.asObservable(),
            wishListButtonDidTap: wishlistButton.rx.tap.asObservable(),
            shoppingSearchTextDidChange: searchView.shoppingSearchBar.rx.text.orEmpty.asObservable(),
            searchButtonDidClick: searchView.shoppingSearchBar.rx.searchButtonClicked.asObservable()
        )
        
        let output = viewModel.transform(from: input)
        
        output.pushToResultViewController
            .drive(with: self) { owner, moveViewType in
                let viewController: UIViewController
                switch moveViewType {
                case .searchResult(let searchText):
                    let viewModel = SearchResultViewModel(searchedText: searchText)
                    viewController = SearchResultViewController(viewModel: viewModel)
                    
                case .favorite:
                    let viewModel = FavoriteViewModel()
                    viewController = FavoriteViewController(viewModel: viewModel)
                    
                case .wishList:
                    let viewModel = WishCategoryViewModel()
                    viewController = WishCategoryViewController(viewModel: viewModel)
                }
                
                owner.navigationController?.pushViewController(viewController, animated: true)
            }
            .disposed(by: disposeBag)
        
        output.alertError
            .drive(with: self) { owner, value in
                let (title, message) = value
                owner.presentAlert(title: title, message: message)
            }
            .disposed(by: disposeBag)
    }
    
    private func setupView() {
        setupNavigation()
    }
    
    private func setupNavigation() {
        navigationItem.title = "MS의 쇼핑쇼핑"
        
        favoriteButton.image = UIImage(systemName: "heart.fill")
        favoriteButton.style = .plain
        
        wishlistButton.image = UIImage(systemName: "hand.thumbsup.fill")
        wishlistButton.style = .plain
        
        navigationItem.rightBarButtonItems = [wishlistButton, favoriteButton]
    }
}
