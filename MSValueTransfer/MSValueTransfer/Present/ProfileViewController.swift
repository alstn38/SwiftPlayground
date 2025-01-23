//
//  ProfileViewController.swift
//  MSValueTransfer
//
//  Created by 강민수 on 1/23/25.
//

import SnapKit
import UIKit

final class ProfileViewController: UIViewController {
    
    private var isNickNameEnter: Bool = false
    private var isBirthdayEnter: Bool = false
    private var isLevelEnter: Bool = false
    private let nickNameLabel = TapAnimationLabel(text: "닉네임")
    private let birthdayLabel = TapAnimationLabel(text: "생일")
    private let levelLabel = TapAnimationLabel(text: "레벨")
    private let saveButton: UIButton = {
        var titleContainer = AttributeContainer()
        titleContainer.font = UIFont.boldSystemFont(ofSize: 20)
        
        var configuration = UIButton.Configuration.filled()
        configuration.attributedTitle = AttributedString("저장하기", attributes: titleContainer)
        
        let button = UIButton(configuration: configuration)
        button.isEnabled = false
        
        return button
    }()
    private lazy var withdrawButton: UIButton = {
        var titleContainer = AttributeContainer()
        titleContainer.font = UIFont.boldSystemFont(ofSize: 20)
        
        var configuration = UIButton.Configuration.filled()
        configuration.attributedTitle = AttributedString("탈퇴하기", attributes: titleContainer)
        configuration.baseBackgroundColor = .red
        configuration.baseForegroundColor = .white
        
        let button = UIButton(configuration: configuration)
        button.addTarget(self, action: #selector(withdrawButtonDidTap), for: .touchUpInside)
        
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        configureHierarchy()
        configureLayout()
    }
    
    private func configureView() {
        view.backgroundColor = .white
    }
    
    private func configureHierarchy() {
        view.addSubviews(
            nickNameLabel,
            birthdayLabel,
            levelLabel,
            saveButton,
            withdrawButton
        )
    }
    
    private func configureLayout() {
        nickNameLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(60)
            $0.height.equalTo(60)
            $0.centerX.equalToSuperview()
        }
        
        birthdayLabel.snp.makeConstraints {
            $0.top.equalTo(nickNameLabel.snp.bottom).offset(30)
            $0.height.equalTo(60)
            $0.centerX.equalToSuperview()
        }
        
        levelLabel.snp.makeConstraints {
            $0.top.equalTo(birthdayLabel.snp.bottom).offset(30)
            $0.height.equalTo(60)
            $0.centerX.equalToSuperview()
        }
        
        saveButton.snp.makeConstraints {
            $0.bottom.equalTo(withdrawButton.snp.top).offset(-30)
            $0.height.equalTo(60)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(40)
        }
        
        withdrawButton.snp.makeConstraints {
            $0.bottom.equalTo(view.keyboardLayoutGuide).inset(30)
            $0.height.equalTo(60)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(40)
        }
    }
    
    @objc private func withdrawButtonDidTap(_ sender: UIButton) {
        guard
            let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
            let window = windowScene.windows.first
        else { return }
        
        let onboardingViewController = OnboardingViewController()
        window.rootViewController = onboardingViewController
        window.makeKeyAndVisible()
    }
}
