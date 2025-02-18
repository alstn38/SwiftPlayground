//
//  NumbersViewController.swift
//  MSRxSwift
//
//  Created by 강민수 on 2/18/25.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class NumbersViewController: UIViewController {
    
    private let disposeBag = DisposeBag()
    
    private let numberTextField1: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .line
        return textField
    }()
    
    private let numberTextField2: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .line
        return textField
    }()
    
    private let numberTextField3: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .line
        return textField
    }()
    
    private let resultLabel = UILabel()
    
    private let lineView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    private let plusLabel: UILabel = {
        let label = UILabel()
        label.text = "+"
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureBinding()
        configureView()
        configureHierarchy()
        configureLayout()
    }
    
    private func configureBinding() {
        Observable.combineLatest(
            numberTextField1.rx.text.orEmpty,
            numberTextField2.rx.text.orEmpty,
            numberTextField3.rx.text.orEmpty
        ) { textValue1, textValue2, textValue3 -> Int in
            return (Int(textValue1) ?? 0) + (Int(textValue2) ?? 0) + (Int(textValue3) ?? 0)
        }
        .map { $0.description }
        .bind(to: resultLabel.rx.text)
        .disposed(by: disposeBag)
    }
    
    private func configureView() {
        view.backgroundColor = .white
    }
    
    private func configureHierarchy() {
        view.addSubview(numberTextField1)
        view.addSubview(numberTextField2)
        view.addSubview(numberTextField3)
        view.addSubview(lineView)
        view.addSubview(resultLabel)
        view.addSubview(plusLabel)
    }
    
    private func configureLayout() {
        numberTextField1.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(150)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(100)
        }
        
        numberTextField2.snp.makeConstraints {
            $0.top.equalTo(numberTextField1.snp.bottom).offset(5)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(100)
        }
        
        numberTextField3.snp.makeConstraints {
            $0.top.equalTo(numberTextField2.snp.bottom).offset(5)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(100)
        }
        
        lineView.snp.makeConstraints {
            $0.top.equalTo(numberTextField3.snp.bottom).offset(5)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(120)
            $0.height.equalTo(1)
        }
        
        resultLabel.snp.makeConstraints {
            $0.top.equalTo(lineView.snp.bottom).offset(5)
            $0.trailing.equalTo(numberTextField3)
        }
        
        plusLabel.snp.makeConstraints {
            $0.trailing.equalTo(numberTextField3.snp.leading).offset(-10)
            $0.centerY.equalTo(numberTextField3)
        }
    }
}
