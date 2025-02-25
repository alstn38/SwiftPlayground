//
//  SearchViewModel.swift
//  MSShopping
//
//  Created by 강민수 on 2/6/25.
//

import Foundation

final class SearchViewModel {
    
    struct Input {
        let shoppingSearchTextDidChange: CustomObservable<String?>
        let searchButtonDidClick: CustomObservable<Void>
    }
    
    struct Output {
        let searchWarningLabelText: CustomObservable<String?>
        let pushToResultViewController: CustomObservable<String>
        let alertError: CustomObservable<String>
    }
    
    private let searchWarningLabelTextSubject: CustomObservable<String?> = CustomObservable(nil)
    private let pushToResultViewControllerSubject: CustomObservable<String> = CustomObservable("")
    private let alertErrorSubject: CustomObservable<String> = CustomObservable("")
    
    private var isValidSearchText: Bool = false
    private var searchedText: String = ""
    
    func transform(from input: Input) -> Output {
        input.shoppingSearchTextDidChange.bind { [weak self] inputText in
            guard let self, let inputText else { return }
            self.isValidSearchText = inputText.count >= 2
            self.searchedText = inputText
            
            let warningLabelText = getWarningLabelText()
            searchWarningLabelTextSubject.send(warningLabelText)
        }
        
        input.searchButtonDidClick.bind { [weak self] _ in
            guard let self else { return }
            
            switch isValidSearchText {
            case true:
                pushToResultViewControllerSubject.send(searchedText)
                
            case false:
                alertErrorSubject.send("최소 2글자 이상 입력해주세요.")
            }
        }
        
        return Output(
            searchWarningLabelText: searchWarningLabelTextSubject,
            pushToResultViewController: pushToResultViewControllerSubject,
            alertError: alertErrorSubject
        )
    }
    
    private func getWarningLabelText() -> String {
        let warningLabelText = isValidSearchText ? "" : "최소 2글자 이상 입력해주세요."
        return warningLabelText
    }
}
