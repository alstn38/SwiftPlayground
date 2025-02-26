//
//  SearchViewModel.swift
//  MSShopping
//
//  Created by 강민수 on 2/6/25.
//

import Foundation
import RxSwift
import RxCocoa

final class SearchViewModel {
    
    struct Input {
        let wishListButtonDidTap: Observable<Void>
        let shoppingSearchTextDidChange: Observable<String>
        let searchButtonDidClick: Observable<Void>
    }
    
    struct Output {
        let pushToResultViewController: Driver<MoveToOtherViewType>
        let alertError: Driver<(title: String, message: String)>
    }
    
    private let disposeBag = DisposeBag()
    
    func transform(from input: Input) -> Output {
        let pushToResultViewControllerRelay = PublishRelay<MoveToOtherViewType>()
        let alertErrorRelay = PublishRelay<(title: String, message: String)>()
        
        input.wishListButtonDidTap
            .map { MoveToOtherViewType.wishList }
            .bind(to: pushToResultViewControllerRelay)
            .disposed(by: disposeBag)
        
        input.searchButtonDidClick
            .withLatestFrom(input.shoppingSearchTextDidChange)
            .bind { searchText in
                if searchText.count < 2 {
                    alertErrorRelay.accept((title: "범위 오류", message: "최소 2글자 이상 입력해주세요."))
                } else {
                    pushToResultViewControllerRelay.accept(MoveToOtherViewType.searchResult(search: searchText))
                }
            }
            .disposed(by: disposeBag)
        
        return Output(
            pushToResultViewController: pushToResultViewControllerRelay.asDriver(onErrorJustReturn: .wishList),
            alertError: alertErrorRelay.asDriver(onErrorJustReturn: (title: "", message: ""))
        )
    }
}

// MARK: - Move To Other ViewController Type
extension SearchViewModel {
    
    enum MoveToOtherViewType {
        case searchResult(search: String)
        case wishList
    }
}
