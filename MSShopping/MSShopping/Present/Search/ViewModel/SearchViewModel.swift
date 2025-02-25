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
        let shoppingSearchTextDidChange: Observable<String>
        let searchButtonDidClick: Observable<Void>
    }
    
    struct Output {
        let pushToResultViewController: Driver<String>
        let alertError: Driver<(title: String, message: String)>
    }
    
    private let disposeBag = DisposeBag()
    
    func transform(from input: Input) -> Output {
        let pushToResultViewControllerRelay = PublishRelay<String>()
        let alertErrorRelay = PublishRelay<(title: String, message: String)>()
        
        input.searchButtonDidClick
            .withLatestFrom(input.shoppingSearchTextDidChange)
            .bind { searchText in
                if searchText.count < 2 {
                    alertErrorRelay.accept((title: "범위 오류", message: "최소 2글자 이상 입력해주세요."))
                } else {
                    pushToResultViewControllerRelay.accept(searchText)
                }
            }
            .disposed(by: disposeBag)
        
        return Output(
            pushToResultViewController: pushToResultViewControllerRelay.asDriver(onErrorJustReturn: ""),
            alertError: alertErrorRelay.asDriver(onErrorJustReturn: (title: "", message: ""))
        )
    }
}
