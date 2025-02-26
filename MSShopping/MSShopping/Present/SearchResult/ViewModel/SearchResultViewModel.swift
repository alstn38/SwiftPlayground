//
//  SearchResultViewModel.swift
//  MSShopping
//
//  Created by 강민수 on 2/6/25.
//

import Foundation
import RxSwift
import RxCocoa

final class SearchResultViewModel {
    
    struct Input {
        let selectedFilterButtonDidTap: Observable<FilterButton.FilterButtonType>
        let willDisplayIndex: Observable<Int>
        let productItemDidTap: Observable<ProductInfo>
    }
    
    struct Output {
        let indicatorAnimate: Driver<Bool>
        let productTotalCount: Driver<Int>
        let searchProduct: Driver<[ProductSection]>
        let moveToDetailView: Driver<String>
        let alertError: Driver<(title: String, message: String)>
    }
    
    private var searchedText: String
    private var currentPage: Int = 1
    private var maximumPage: Int = 1
    private let disposeBag = DisposeBag()
    
    init(searchedText: String) {
        self.searchedText = searchedText
    }
    
    func transform(from input: Input) -> Output {
        let indicatorAnimateRelay = BehaviorRelay(value: true)
        let productTotalCountRelay = PublishRelay<Int>()
        let searchProductRelay: BehaviorRelay<[ProductSection]> = BehaviorRelay(value: [])
        let moveToDetailViewRelay = PublishRelay<String>()
        let alertErrorRelay = PublishRelay<(title: String, message: String)>()
        
        input.selectedFilterButtonDidTap
            .withUnretained(self)
            .filter { $0.0.currentPage != 1 }
            .bind(with: self) { owner, _ in
                owner.currentPage = 1
                owner.maximumPage = 1
            }
            .disposed(by: disposeBag)
        
        input.selectedFilterButtonDidTap
            .withUnretained(self)
            .map { ($0.0.searchedText, $0.1.query, $0.0.currentPage) }
            .flatMap { NetworkManager.shared.getShoppingResult(searchedText: $0, sortType: $1, page: $2) }
            .bind(with: self) { owner, response in
                indicatorAnimateRelay.accept(false)
                switch response {
                case .success(let value):
                    owner.currentPage += 1
                    owner.maximumPage = Int(ceil(Double(value.total) / Double(100)))
                    searchProductRelay.accept([ProductSection(items: value.items)])
                    
                case .failure(let error):
                    alertErrorRelay.accept((title: "네트워크 오류", message: error.errorDescription))
                }
            }
            .disposed(by: disposeBag)
        
        input.willDisplayIndex
            .filter { (searchProductRelay.value.first?.items.count ?? 0) - 3 == $0 }
            .withUnretained(self)
            .filter { $0.0.currentPage < $0.0.maximumPage }
            .withLatestFrom(input.selectedFilterButtonDidTap)
            .withUnretained(self)
            .map { ($0.0.searchedText, $0.1.query, $0.0.currentPage) }
            .flatMap { NetworkManager.shared.getShoppingResult(searchedText: $0, sortType: $1, page: $2) }
            .bind(with: self) { owner, response in
                switch response {
                case .success(let value):
                    owner.currentPage += 1
                    var existingArray = searchProductRelay.value.first?.items ?? []
                    existingArray.append(contentsOf: value.items)
                    searchProductRelay.accept([ProductSection(items: existingArray)])
                    
                case .failure(let error):
                    alertErrorRelay.accept((title: "네트워크 오류", message: error.errorDescription))
                }
            }
            .disposed(by: disposeBag)
        
        input.productItemDidTap
            .map { $0.link.replacingOccurrences(of: "\\", with: "") }
            .bind(to: moveToDetailViewRelay)
            .disposed(by: disposeBag)
        
        return Output(
            indicatorAnimate: indicatorAnimateRelay.asDriver(),
            productTotalCount: productTotalCountRelay.asDriver(onErrorJustReturn: 0),
            searchProduct: searchProductRelay.asDriver(),
            moveToDetailView: moveToDetailViewRelay.asDriver(onErrorJustReturn: ""),
            alertError: alertErrorRelay.asDriver(onErrorJustReturn: (title: "", message: ""))
        )
    }
}
