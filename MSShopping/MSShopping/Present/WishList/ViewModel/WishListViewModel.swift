//
//  WishListViewModel.swift
//  MSShopping
//
//  Created by 강민수 on 3/5/25.
//

import Foundation
import RxSwift
import RxCocoa

protocol WishListViewModelProtocol: AnyObject {
    func wishListDidUpdate(_ viewModel: WishListViewModel)
}

final class WishListViewModel {
    
    struct Input {
        let addWishList: Observable<String>
    }
    
    struct Output {
        let folderName: Driver<String>
        let updateWishList: Driver<[WishList]>
        let alertError: Driver<(title: String, message: String)>
    }
    
    weak var delegate: WishListViewModelProtocol?
    private let folder: WishCategory
    private let wishListRepository: WishListRepository
    private let disposeBag = DisposeBag()
    
    init(folder: WishCategory, wishListRepository: WishListRepository = DefaultWishListRepository()) {
        self.folder = folder
        self.wishListRepository = wishListRepository
    }
    
    func transform(from input: Input) -> Output {
        let folderNameRelay = BehaviorRelay(value: folder.folderName)
        let updateWishListRelay: BehaviorRelay<[WishList]> = BehaviorRelay(value: Array(folder.detail))
        let alertErrorRelay = PublishRelay<(title: String, message: String)>()
        
        input.addWishList
            .bind(with: self) { owner, wishListName in
                do {
                    try owner.wishListRepository.createItem(folder: owner.folder, name: wishListName)
                    updateWishListRelay.accept(Array(owner.folder.detail))
                    owner.delegate?.wishListDidUpdate(owner)
                } catch {
                    alertErrorRelay.accept((title: "로컬 데이터 오류", message: error.localizedDescription))
                }
            }
            .disposed(by: disposeBag)
        
        return Output(
            folderName: folderNameRelay.asDriver(),
            updateWishList: updateWishListRelay.asDriver(),
            alertError: alertErrorRelay.asDriver(onErrorJustReturn: (title: "", message: ""))
        )
    }
}

extension WishListViewModel {
    
    enum Section: CaseIterable {
        case product
    }
}
