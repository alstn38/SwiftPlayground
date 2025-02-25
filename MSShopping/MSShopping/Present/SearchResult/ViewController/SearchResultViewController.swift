//
//  SearchResultViewController.swift
//  MSShopping
//
//  Created by 강민수 on 1/15/25.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

final class SearchResultViewController: UIViewController {
    
    private let searchResultView = SearchResultView()
    private let viewModel: SearchResultViewModel
    private let filterButtonRelay = BehaviorRelay(value: FilterButton.FilterButtonType.accuracy)
    private let disposeBag = DisposeBag()
    
    private let dataSource = RxCollectionViewSectionedReloadDataSource<ProductSection> { dataSource, collectionView, indexPath, item in
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ProductCollectionViewCell.identifier,
            for: indexPath
        ) as? ProductCollectionViewCell else { return UICollectionViewCell() }
        
        cell.configureCell(item)
        return cell
    }
    
    init(viewModel: SearchResultViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = searchResultView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBind()
        setupCollectionView()
    }
    
    private func setupBind() {
        let input = SearchResultViewModel.Input(
            selectedFilterButtonDidTap: filterButtonRelay.asObservable(),
            willDisplayIndex: searchResultView.productCollectionView.rx.willDisplayCell.map { $0.at.row }.asObservable()
        )
        
        let output = viewModel.transform(from: input)
        
        output.indicatorAnimate
            .drive(with: self) { owner, isAnimate in
                if isAnimate {
                    owner.searchResultView.indicatorView.startAnimating()
                } else {
                    owner.searchResultView.indicatorView.stopAnimating()
                }
            }
            .disposed(by: disposeBag)
        
        output.productTotalCount
            .drive(with: self) { owner, count in
                owner.searchResultView.searchTotalCountLabel.text = count.formatted() + "개의 검색결과"
            }
            .disposed(by: disposeBag)
        
        output.searchProduct
            .drive(searchResultView.productCollectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        output.alertError
            .drive(with: self) { owner, value in
                let (title, message) = value
                owner.presentAlert(title: title, message: message)
            }
            .disposed(by: disposeBag)
        
        for button in searchResultView.filterButtonArray {
            button.rx.tap
                .bind(with: self) { owner, _ in
                    let buttonType = FilterButton.FilterButtonType(rawValue: button.tag) ?? .accuracy
                    owner.filterButtonRelay.accept(buttonType)
                    owner.searchResultView.productCollectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: false)
                    owner.searchResultView.filterButtonArray.forEach { $0.isSelected = false }
                    button.isSelected = true
                }
                .disposed(by: disposeBag)
        }
    }
    
    private func setupCollectionView() {
        searchResultView.productCollectionView.register(
            ProductCollectionViewCell.self,
            forCellWithReuseIdentifier: ProductCollectionViewCell.identifier
        )
    }
}
