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
        textField.placeholder = "이메일 주소 또는 전화번호"
        textField.borderStyle = .none
        textField.keyboardType = .emailAddress
        textField.textColor = .white
        textField.backgroundColor = .systemGray2
        textField.textAlignment = .center
        textField.returnKeyType = .done
        textField.layer.cornerRadius = 5
        
        return textField
    }()
    
    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "비밀번호"
        textField.borderStyle = .none
        textField.textColor = .white
        textField.backgroundColor = .systemGray2
        textField.textAlignment = .center
        textField.returnKeyType = .done
        textField.layer.cornerRadius = 5
        
        return textField
    }()
    
    private let nickNameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "닉네임"
        textField.borderStyle = .none
        textField.textColor = .white
        textField.backgroundColor = .systemGray2
        textField.textAlignment = .center
        textField.returnKeyType = .done
        textField.layer.cornerRadius = 5
        
        return textField
    }()
    
    private let locationTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "위치"
        textField.borderStyle = .none
        textField.textColor = .white
        textField.backgroundColor = .systemGray2
        textField.textAlignment = .center
        textField.returnKeyType = .done
        textField.layer.cornerRadius = 5
        
        return textField
    }()
    
    private let recommendTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "추천 코드 입력"
        textField.borderStyle = .none
        textField.keyboardType = .numberPad
        textField.textColor = .white
        textField.backgroundColor = .systemGray2
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
        
    }
}
