//
//  CurrencyExchangeViewController.swift
//  MSObservable
//
//  Created by 강민수 on 2/5/25.
//

import SnapKit
import UIKit

final class CurrencyExchangeViewController: UIViewController {
    
    private let viewModel = CurrencyExchangeViewModel()
    
    private let exchangeRateLabel: UILabel = {
        let label = UILabel()
        label.text = "현재 환율: 1 USD = 1,350 KRW"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 16, weight: .medium)
        return label
    }()
    
    private let amountTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "원화 금액을 입력하세요"
        textField.borderStyle = .roundedRect
        textField.keyboardType = .numberPad
        textField.textAlignment = .center
        return textField
    }()
    
    private let convertButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("환전하기", for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        return button
    }()
    
    private let resultLabel: UILabel = {
        let label = UILabel()
        label.text = "환전 결과가 여기에 표시됩니다"
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 16, weight: .medium)
        return label
    }()
     
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBind()
        setupUI()
        setupConstraints()
        setupActions()
    }
    
    private func setupBind() {
        viewModel.outputAmountResultLabelText.bind { [weak self] text in
            self?.resultLabel.text = text
        }
    }
     
    private func setupUI() {
        view.backgroundColor = .white
        
        [exchangeRateLabel, amountTextField, convertButton, resultLabel].forEach {
            view.addSubview($0)
        }
    }
    
    private func setupConstraints() {
        exchangeRateLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(40)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        amountTextField.snp.makeConstraints { make in
            make.top.equalTo(exchangeRateLabel.snp.bottom).offset(30)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(50)
        }
        
        convertButton.snp.makeConstraints { make in
            make.top.equalTo(amountTextField.snp.bottom).offset(30)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(50)
        }
        
        resultLabel.snp.makeConstraints { make in
            make.top.equalTo(convertButton.snp.bottom).offset(30)
            make.leading.trailing.equalToSuperview().inset(20)
        }
    }
    
    private func setupActions() {
        amountTextField.addTarget(self, action: #selector(amountTextFieldEditingChanged), for: .editingChanged)
        convertButton.addTarget(self, action: #selector(convertButtonTapped), for: .touchUpInside)
    }
    
    @objc private func amountTextFieldEditingChanged(_ sender: UITextField) {
        viewModel.inputAmountTextFieldTextDidChange.value = sender.text
    }
    
    @objc private func convertButtonTapped(_sender: UIButton) {
        viewModel.inputConvertButtonDidTap.value = ()
    }
}
