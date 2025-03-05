//
//  WishCategoryViewModel.swift
//  MSShopping
//
//  Created by 강민수 on 3/5/25.
//

import Foundation
import RxSwift
import RxCocoa

final class WishCategoryViewModel {
    
    struct Input {
        let addFolder: Observable<String>
        let cellDidTap: Observable<Int>
    }
    
    struct Output {
        let updateFolder: Driver<[WishCategory]>
        let moveToDetailView: Driver<WishCategory>
        let alertError: Driver<(title: String, message: String)>
    }
    
    private let wishCategoryRepository: WishCategoryRepository
    private let disposeBag = DisposeBag()
    
    init(wishCategoryRepository: WishCategoryRepository = DefaultWishCategoryRepository()) {
        self.wishCategoryRepository = wishCategoryRepository
    }
    
    func transform(from input: Input) -> Output {
        let updateFolderRelay: BehaviorRelay<[WishCategory]> = BehaviorRelay(value: wishCategoryRepository.readItem())
        let moveToDetailViewRelay = PublishRelay<WishCategory>()
        let alertErrorRelay = PublishRelay<(title: String, message: String)>()
        
        input.addFolder
            .bind(with: self) { owner, folderName in
                do {
                    try owner.wishCategoryRepository.createItem(name: folderName)
                    updateFolderRelay.accept(owner.wishCategoryRepository.readItem())
                } catch {
                    alertErrorRelay.accept((title: "로컬 오류", message: error.localizedDescription))
                }
            }
            .disposed(by: disposeBag)
        
        input.cellDidTap
            .map { updateFolderRelay.value[$0] }
            .bind(to: moveToDetailViewRelay)
            .disposed(by: disposeBag)
        
        return Output(
            updateFolder: updateFolderRelay.asDriver(),
            moveToDetailView: moveToDetailViewRelay.asDriver(onErrorJustReturn: WishCategory(folderName: "")),
            alertError: alertErrorRelay.asDriver(onErrorJustReturn: (title: "", message: ""))
        )
    }
}

extension WishCategoryViewModel {
    
    enum Section: CaseIterable {
        case folder
    }
}
