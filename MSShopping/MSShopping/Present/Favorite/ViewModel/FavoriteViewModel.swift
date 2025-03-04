//
//  FavoriteViewModel.swift
//  MSShopping
//
//  Created by 강민수 on 3/4/25.
//

import Foundation
import RealmSwift
import RxSwift
import RxCocoa

final class FavoriteViewModel {
    
    struct Input {
        let viewDidLoad: Observable<Void>
        let searchTextDidChange: Observable<String>
        let cellFavoriteDidTap: Observable<ProductEntity>
        let updateSnapShot: Observable<Void>
    }
    
    struct Output {
        let updateFavoriteProduct: Driver<[FavoriteProduct]>
        let alertError: Driver<(title: String, message: String)>
    }
    
    private let realm = try! Realm()
    private var deleteStack: [ProductEntity] = []
    private let alertErrorRelay = PublishRelay<(title: String, message: String)>()
    private let disposeBag = DisposeBag()
    
    func transform(from input: Input) -> Output {
        let updateFavoriteProductRelay = BehaviorRelay<[FavoriteProduct]>(value: [])
        
        input.viewDidLoad
            .bind(with: self) { owner, _ in
                updateFavoriteProductRelay.accept(Array(owner.realm.objects(FavoriteProduct.self)))
            }
            .disposed(by: disposeBag)
        
        input.searchTextDidChange
            .bind(with: self) { owner, text in
                let updateProduct = text.isEmpty
                ? Array(owner.realm.objects(FavoriteProduct.self))
                : Array(
                    owner.realm.objects(FavoriteProduct.self)
                        .where { $0.title.contains(text, options: .caseInsensitive) }
                )
                
                updateFavoriteProductRelay.accept(updateProduct)
            }
            .disposed(by: disposeBag)
        
        input.cellFavoriteDidTap
            .withLatestFrom(input.searchTextDidChange) { ($0, $1) }
            .bind(with: self) { owner, value in
                let (product, text) = value
                owner.deleteStack.append(product)
                
                let updateProduct = text.isEmpty
                ? Array(owner.realm.objects(FavoriteProduct.self).where { $0.productId != product.productId })
                : Array(
                    owner.realm.objects(FavoriteProduct.self)
                        .where { $0.title.contains(text, options: .caseInsensitive) }
                )
                
                updateFavoriteProductRelay.accept(updateProduct)
            }
            .disposed(by: disposeBag)
        
        input.updateSnapShot
            .bind(with: self) { owner, _ in
                guard let deleteData = owner.deleteStack.popLast() else { return }
                owner.deleteFavoriteProductRealm(with: deleteData)
            }
            .disposed(by: disposeBag)
        
        return Output(
            updateFavoriteProduct: updateFavoriteProductRelay.asDriver(),
            alertError: alertErrorRelay.asDriver(onErrorJustReturn: (title: "", message: ""))
        )
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

extension FavoriteViewModel {
    
    enum Section: CaseIterable {
        case favorite
    }
}
