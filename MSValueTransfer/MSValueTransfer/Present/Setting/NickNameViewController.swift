//
//  NickNameViewController.swift
//  MSValueTransfer
//
//  Created by 강민수 on 1/23/25.
//

import SnapKit
import UIKit

final class NickNameViewController: UIViewController {
    
    let nickNameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "닉네임을 입력해주세요."
        textField.textColor = .black
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private lazy var confirmButton: UIButton = {
        var titleContainer = AttributeContainer()
        titleContainer.font = UIFont.boldSystemFont(ofSize: 20)
        
        var configuration = UIButton.Configuration.filled()
        configuration.attributedTitle = AttributedString("확인", attributes: titleContainer)
        
        let button = UIButton(configuration: configuration)
        button.addTarget(self, action: #selector(confirmButtonDidTap), for: .touchUpInside)
        
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        configureHierarchy()
        configureLayout()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        postNotification()
    }
    
    private func configureView() {
        view.backgroundColor = .white
    }
    
    private func configureHierarchy() {
        view.addSubviews(
            nickNameTextField,
            confirmButton
        )
    }
    
    private func configureLayout() {
        nickNameTextField.snp.makeConstraints {
            $0.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(30)
            $0.height.equalTo(34)
        }
        
        confirmButton.snp.makeConstraints {
            $0.bottom.equalTo(view.keyboardLayoutGuide.snp.top).offset(-30)
            $0.height.equalTo(60)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(40)
        }
    }
    
    private func postNotification() {
        guard let newNickName = nickNameTextField.text else { return }
        guard !newNickName.isEmpty else { return }
        
        NotificationCenter.default.post(
            name: NSNotification.Name("nickNameTextFieldDidChange"),
            object: nil,
            userInfo: ["nickName": newNickName]
        )
    }
    
    @objc private func confirmButtonDidTap(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}
