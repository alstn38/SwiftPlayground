//
//  SimpleValidationViewController.swift
//  MSRxSwift
//
//  Created by 강민수 on 2/18/25.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

private let minimalUsernameLength = 5
private let minimalPasswordLength = 5

final class SimpleValidationViewController: UIViewController {
    
    private let disposeBag = DisposeBag()
    private let userNameLabel = UILabel()
    private let nameTextField = UITextField()
    private let userNameValidLabel = UILabel()
    private let passwordLabel = UILabel()
    private let passwordTextField = UITextField()
    private let passwordValidLabel = UILabel()
    private let doSomethingButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureBinding()
        configureView()
        configureHierarchy()
        configureLayout()
    }
    
    private func configureBinding() {
        let userNameValid = nameTextField.rx.text.orEmpty
            .map { $0.count >= minimalUsernameLength }
            .share(replay: 1)
        
        let passwordValid = passwordTextField.rx.text.orEmpty
            .map { $0.count >= minimalPasswordLength }
            .share(replay: 1)
        
        let everythingValid = Observable.combineLatest(userNameValid, passwordValid) { $0 && $1 }
            .share(replay: 1)
        
        userNameValid
            .bind(to: passwordTextField.rx.isEnabled)
            .disposed(by: disposeBag)
        
        userNameValid
            .bind(to: userNameValidLabel.rx.isHidden)
            .disposed(by: disposeBag)
        
        passwordValid
            .bind(to: passwordValidLabel.rx.isHidden)
            .disposed(by: disposeBag)
        
        everythingValid
            .bind(to: doSomethingButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        doSomethingButton.rx.tap
            .bind(with: self) { owner, _ in
                let alertView = UIAlertController(
                    title: "RxExample",
                    message: "Do Something !!",
                    preferredStyle: .alert
                )
                alertView.addAction(UIAlertAction(title: "OK", style: .cancel))
                owner.present(alertView, animated: true)
            }
            .disposed(by: disposeBag)
    }

    private func configureView() {
        view.backgroundColor = .white
        
        userNameLabel.text = "Username"
        nameTextField.borderStyle = .bezel
        userNameValidLabel.text = "Username has to be at least \(minimalUsernameLength) characters"
        userNameValidLabel.textColor = .systemRed
        
        passwordLabel.text = "Username"
        passwordTextField.borderStyle = .bezel
        passwordValidLabel.text = "Password has to be at least \(minimalPasswordLength) characters"
        passwordValidLabel.textColor = .systemRed
        
        doSomethingButton.backgroundColor = .green
        doSomethingButton.setTitle("Do something", for: .normal)
    }
    
    private func configureHierarchy() {
        view.addSubview(userNameLabel)
        view.addSubview(nameTextField)
        view.addSubview(userNameValidLabel)
        view.addSubview(passwordLabel)
        view.addSubview(passwordTextField)
        view.addSubview(passwordValidLabel)
        view.addSubview(doSomethingButton)
    }
    
    private func configureLayout() {
        userNameLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(50)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
        }
        
        nameTextField.snp.makeConstraints {
            $0.top.equalTo(userNameLabel.snp.bottom).offset(5)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        userNameValidLabel.snp.makeConstraints {
            $0.top.equalTo(nameTextField.snp.bottom).offset(5)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        passwordLabel.snp.makeConstraints {
            $0.top.equalTo(userNameValidLabel.snp.bottom).offset(5)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
        }
        
        passwordTextField.snp.makeConstraints {
            $0.top.equalTo(passwordLabel.snp.bottom).offset(5)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        passwordValidLabel.snp.makeConstraints {
            $0.top.equalTo(passwordTextField.snp.bottom).offset(5)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        doSomethingButton.snp.makeConstraints {
            $0.top.equalTo(passwordValidLabel.snp.bottom).offset(10)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.height.equalTo(34)
        }
    }
}
