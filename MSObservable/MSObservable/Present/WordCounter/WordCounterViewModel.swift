//
//  WordCounterViewModel.swift
//  MSObservable
//
//  Created by 강민수 on 2/5/25.
//

import Foundation

final class WordCounterViewModel {
    
    let inputTextFieldTextDidChange: Observable<String> = Observable("")
    let outputCountLabelText: Observable<String?> = Observable("")
    
    init() {
        inputTextFieldTextDidChange.bind { [weak self] text in
            self?.updateCharacterCount(text)
        }
    }
    
    private func updateCharacterCount(_ text: String) {
        let count = text.count
        outputCountLabelText.value = "현재까지 \(count)글자 작성중"
    }
}
