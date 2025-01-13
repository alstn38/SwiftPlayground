//
//  MinFlixViewController.swift
//  MSMinFlix
//
//  Created by 강민수 on 1/13/25.
//

import SnapKit
import UIKit

final class MinFlixViewController: UIViewController {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "MINFLIX"
        label.font = .systemFont(ofSize: 40, weight: .bold)
        label.textColor = .systemPink
        label.textAlignment = .center
        
        return label
    }()
    
    private let emailTextField: UITextField = {
        let textField = UITextField()
        textField.setPlaceholder(placeholder: "이메일 주소 또는 전화번호", color: .systemGray5)
        textField.borderStyle = .none
        textField.keyboardType = .emailAddress
        textField.textColor = .white
        textField.backgroundColor = .gray
        textField.textAlignment = .center
        textField.returnKeyType = .done
        textField.layer.cornerRadius = 5
        
        return textField
    }()
    
    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.setPlaceholder(placeholder: "비밀번호", color: .systemGray5)
        textField.borderStyle = .none
        textField.textColor = .white
        textField.backgroundColor = .gray
        textField.textAlignment = .center
        textField.returnKeyType = .done
        textField.layer.cornerRadius = 5
        
        return textField
    }()
    
    private let nickNameTextField: UITextField = {
        let textField = UITextField()
        textField.setPlaceholder(placeholder: "닉네임", color: .systemGray5)
        textField.borderStyle = .none
        textField.textColor = .white
        textField.backgroundColor = .gray
        textField.textAlignment = .center
        textField.returnKeyType = .done
        textField.layer.cornerRadius = 5
        
        return textField
    }()
    
    private let locationTextField: UITextField = {
        let textField = UITextField()
        textField.setPlaceholder(placeholder: "위치", color: .systemGray5)
        textField.borderStyle = .none
        textField.textColor = .white
        textField.backgroundColor = .gray
        textField.textAlignment = .center
        textField.returnKeyType = .done
        textField.layer.cornerRadius = 5
        
        return textField
    }()
    
    private let recommendTextField: UITextField = {
        let textField = UITextField()
        textField.setPlaceholder(placeholder: "추천 코드 입력", color: .systemGray5)
        textField.borderStyle = .none
        textField.keyboardType = .numberPad
        textField.textColor = .white
        textField.backgroundColor = .gray
        textField.textAlignment = .center
        textField.returnKeyType = .done
        textField.layer.cornerRadius = 5
        
        return textField
    }()
    
    private let signUpButton: UIButton = {
        let button = UIButton()
        button.setTitle("회원가입", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        button.backgroundColor = .white
        button.layer.cornerRadius = 5
        button.clipsToBounds = true
        
        return button
    }()
    
    private let additionalInfoButton: UIButton = {
        let button = UIButton()
        button.setTitle("추가 정보 입력", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .regular)
        button.backgroundColor = .clear
        
        return button
    }()
    
    private let toggleSwitch: UISwitch = {
        let toggleSwitch = UISwitch()
        toggleSwitch.isOn = true
        toggleSwitch.onTintColor = .systemPink
        toggleSwitch.thumbTintColor = .white
        
        return toggleSwitch
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("MinFlix - viewDidLoad")
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("MinFlix - viewWillAppear")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("MinFlix - viewDidAppear")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("MinFlix - viewWillDisappear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("MinFlix - viewDidDisappear")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    private func setupView() {
        view.backgroundColor = .black
        
        setupHierarchy()
        setupLayout()
    }
    
    private func setupHierarchy() {
        [
            titleLabel, emailTextField, passwordTextField,
            nickNameTextField, locationTextField, recommendTextField,
            signUpButton, additionalInfoButton, toggleSwitch
        ].forEach {
            view.addSubview($0)
        }
    }
    
    private func setupLayout() {
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            $0.centerX.equalToSuperview()
        }
        
        emailTextField.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(100)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(40)
            $0.height.equalTo(36)
        }
        
        passwordTextField.snp.makeConstraints {
            $0.top.equalTo(emailTextField.snp.bottom).offset(10)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(40)
            $0.height.equalTo(36)
        }
        
        nickNameTextField.snp.makeConstraints {
            $0.top.equalTo(passwordTextField.snp.bottom).offset(10)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(40)
            $0.height.equalTo(36)
        }
        
        locationTextField.snp.makeConstraints {
            $0.top.equalTo(nickNameTextField.snp.bottom).offset(10)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(40)
            $0.height.equalTo(36)
        }
        
        recommendTextField.snp.makeConstraints {
            $0.top.equalTo(locationTextField.snp.bottom).offset(10)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(40)
            $0.height.equalTo(36)
        }
        
        signUpButton.snp.makeConstraints {
            $0.top.equalTo(locationTextField.snp.bottom).offset(10)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(40)
            $0.height.equalTo(40)
        }
        
        additionalInfoButton.snp.makeConstraints {
            $0.top.equalTo(signUpButton.snp.bottom).offset(10)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(40)
            $0.height.equalTo(40)
            $0.width.equalTo(100)
        }
        
        toggleSwitch.snp.makeConstraints {
            $0.top.equalTo(signUpButton.snp.bottom).offset(10)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).inset(40)
        }
    }
}
