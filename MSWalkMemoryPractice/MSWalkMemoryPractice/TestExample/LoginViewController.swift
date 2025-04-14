//
//  LoginViewController.swift
//  MSWalkMemoryPractice
//
//  Created by 강민수 on 4/7/25.
//

import UIKit

final class LoginViewController: UIViewController {
    
    @IBOutlet var idTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var checkPasswordTextField: UITextField!
    @IBOutlet var loginButton: UIButton!
    @IBOutlet var resultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        idTextField.accessibilityIdentifier = "idTextField"
        passwordTextField.accessibilityIdentifier = "passwordTextField"
        checkPasswordTextField.accessibilityIdentifier = "checkPasswordTextField"
        loginButton.accessibilityIdentifier = "loginButton"
    }
    
    @IBAction func loginButtonDidTap(_ sender: UIButton) {
        if isValidID() && isValidPassword() && isEqualPassword() {
            resultLabel.text = "성공"
        } else { resultLabel.text = "실패"}
    }
    
    
    func isValidID() -> Bool {
        guard let email = idTextField.text else { return false }
        return email.contains("@") && email.count  >= 6
    }
    func isValidPassword() -> Bool {
        guard let password = passwordTextField.text else { return false }
        return password.count >= 6 && password.count < 10
    }
    func isEqualPassword() -> Bool {
        guard let password = passwordTextField.text,
              let check = checkPasswordTextField.text else {
            return false }
        return password == check
    }
}
