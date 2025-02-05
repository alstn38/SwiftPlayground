//
//  CurrencyExchangeViewModel.swift
//  MSObservable
//
//  Created by 강민수 on 2/5/25.
//

import Foundation

final class CurrencyExchangeViewModel {
    
    let inputAmountTextFieldTextDidChange: Observable<String?> = Observable(nil)
    let inputConvertButtonDidTap: Observable<Void> = Observable(())
    let outputAmountResultLabelText: Observable<String> = Observable("")
    
    private var amountResultLabelText: String = ""
    
    init() {
        inputAmountTextFieldTextDidChange.bind { [weak self] text in
            self?.validateAmount(text)
        }
        
        inputConvertButtonDidTap.bind { [weak self] _ in
            guard let self else { return }
            outputAmountResultLabelText.value = amountResultLabelText
        }
    }
    
    private func validateAmount(_ text: String?) {
        guard
            let amountText = text,
            let amount = Int(amountText)
        else {
            outputAmountResultLabelText.value = "올바른 금액을 입력해주세요"
            return
        }
        
        let exchangeRate = 1350.0
        let convertedAmount: Double = Double(amount) / exchangeRate
        outputAmountResultLabelText.value = "환전 가능한 금액입니다."
        amountResultLabelText = String(format: "%.2f USD (약 $%.2f)", convertedAmount, convertedAmount)
    }
}
