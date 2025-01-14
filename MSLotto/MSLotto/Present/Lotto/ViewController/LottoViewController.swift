//
//  LottoViewController.swift
//  MSLotto
//
//  Created by 강민수 on 1/14/25.
//

import UIKit

final class LottoViewController: UIViewController {
    
    private let lottoTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .line
        textField.textAlignment = .center
        textField.font = .systemFont(ofSize: 18, weight: .medium)
        return textField
    }()
    
    private let lottoNumberPickerView: UIPickerView = {
        let pickerView = UIPickerView()
        return pickerView
    }()
    
    private let numberGuideLabel: UILabel = {
        let label = UILabel()
        label.text = "당첨번호 안내"
        label.font = .systemFont(ofSize: 12, weight: .medium)
        return label
    }()
    
    private let drawDateLabel: UILabel = {
        let label = UILabel()
        label.text = "당첨번호 안내"
        label.font = .systemFont(ofSize: 11, weight: .medium)
        label.textColor = .lightGray
        return label
    }()
    
    private let lineView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray4
        return view
    }()
    
    private let winningLabelStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 5
        stackView.alignment = .center
        return stackView
    }()
    
    private let winningNumberLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textColor = .yellow
        return label
    }()
    
    private let winningMessageLabel: UILabel = {
        let label = UILabel()
        label.text = "당첨결과"
        label.font = .systemFont(ofSize: 24, weight: .medium)
        label.textColor = .black
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
