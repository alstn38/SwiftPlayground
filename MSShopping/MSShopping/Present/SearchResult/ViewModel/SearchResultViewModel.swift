//
//  SearchResultViewModel.swift
//  MSShopping
//
//  Created by 강민수 on 2/6/25.
//

import Foundation
import RealmSwift
import RxSwift
import RxCocoa

final class SearchResultViewModel {
    
    struct Input {
        let selectedFilterButtonDidTap: Observable<FilterButton.FilterButtonType>
        let willDisplayIndex: Observable<Int>
        let productItemDidTap: Observable<ProductEntity>
        let favoriteButtonDidTap: Observable<Int>
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
    private let realm = try! Realm()
    private let disposeBag = DisposeBag()
    private let alertErrorRelay = PublishRelay<(title: String, message: String)>()
    
    init(searchedText: String) {
        self.searchedText = searchedText
    }
    
    func transform(from input: Input) -> Output {
        let indicatorAnimateRelay = BehaviorRelay(value: true)
        let productTotalCountRelay = PublishRelay<Int>()
        let searchProductRelay: BehaviorRelay<[ProductSection]> = BehaviorRelay(value: [])
        let moveToDetailViewRelay = PublishRelay<String>()
        
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
                    let newItems = value.items.map {
                        if self.realm.object(ofType: FavoriteProduct.self, forPrimaryKey: $0.productId) == nil {
                            $0.toEntity(isFavorite: false)
                        } else {
                            $0.toEntity(isFavorite: true)
                        }
                    }
                    searchProductRelay.accept([ProductSection(items: newItems)])
                    
                case .failure(let error):
                    owner.alertErrorRelay.accept((title: "네트워크 오류", message: error.errorDescription))
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
                    let newItems = value.items.map {
                        if self.realm.object(ofType: FavoriteProduct.self, forPrimaryKey: $0.productId) == nil {
                            $0.toEntity(isFavorite: false)
                        } else {
                            $0.toEntity(isFavorite: true)
                        }
                    }
                    existingArray.append(contentsOf: newItems)
                    searchProductRelay.accept([ProductSection(items: existingArray)])
                    
                case .failure(let error):
                    owner.alertErrorRelay.accept((title: "네트워크 오류", message: error.errorDescription))
                }
            }
            .disposed(by: disposeBag)
        
        input.productItemDidTap
            .map { $0.link.replacingOccurrences(of: "\\", with: "") }
            .bind(to: moveToDetailViewRelay)
            .disposed(by: disposeBag)
        
        input.favoriteButtonDidTap
            .bind(with: self) { owner, row in
                var existingArray = searchProductRelay.value.first?.items ?? []
                existingArray[row].favorite.toggle()
                searchProductRelay.accept([ProductSection(items: existingArray)])
                
                owner.updateFavoriteProductRealm(with: existingArray[row])
            }
            .disposed(by: disposeBag)
        
        return Output(
            indicatorAnimate: indicatorAnimateRelay.asDriver(),
            productTotalCount: productTotalCountRelay.asDriver(onErrorJustReturn: 0),
            searchProduct: searchProductRelay.asDriver(),
            moveToDetailView: moveToDetailViewRelay.asDriver(onErrorJustReturn: ""),
            alertError: alertErrorRelay.asDriver(onErrorJustReturn: (title: "", message: ""))
        )
    }
    
    /// ProductRealm에 있는 Favorite 정보를 업데이트하는 메서드 (제거, 추가에 대한 분기처리.)
    private func updateFavoriteProductRealm(with item: ProductEntity) {
        if item.favorite {
            createFavoriteProductRealm(with: item)
        } else {
            deleteFavoriteProductRealm(with: item)
        }
    }
    
    /// ProductRealm에 있는 Favorite 정보를 새롭게 추가하는 메서드
    private func createFavoriteProductRealm(with item: ProductEntity) {
        do {
            try realm.write {
                let data = FavoriteProduct(item)
                realm.add(data)
                // TODO: 저장완료 토스트뷰 추가
            }
        } catch {
            alertErrorRelay.accept((title: "로컬 오류", message: "로컬 데이터 저장에 실패했습니다."))
        }
    }
    
    /// ProductRealm에 있는 Favorite 정보를 제거하는 메서드
    private func deleteFavoriteProductRealm(with item: ProductEntity) {
        guard let data = realm.object(ofType: FavoriteProduct.self, forPrimaryKey: item.productId) else {
            return
        }
        
        do {
            try realm.write {
                realm.delete(data)
            }
        } catch {
            alertErrorRelay.accept((title: "로컬 오류", message: "로컬 데이터 업데이트에 실패했습니다."))
        }
    }
}
