//
//  ProfileViewController.swift
//  MSValueTransfer
//
//  Created by 강민수 on 1/23/25.
//

import SnapKit
import UIKit

final class ProfileViewController: UIViewController {
    
    private var isNickNameEnter: Bool = false {
        didSet {
            if isNickNameEnter && isBirthdayEnter && isLevelEnter {
                saveButton.isEnabled = true
            }
        }
    }
    
    private var isBirthdayEnter: Bool = false {
        didSet {
            if isNickNameEnter && isBirthdayEnter && isLevelEnter {
                saveButton.isEnabled = true
            }
        }
    }
    
    private var isLevelEnter: Bool = false {
        didSet {
            if isNickNameEnter && isBirthdayEnter && isLevelEnter {
                saveButton.isEnabled = true
            }
        }
    }
    
    private let dateformatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 MM월 dd일"
        return formatter
    }()
    
    private lazy var nickNameLabel: TapAnimationLabel = {
        let label = TapAnimationLabel(text: "닉네임")
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(nickNameLabelDidTap))
        label.addGestureRecognizer(tapGesture)
        return label
    }()
    
    private lazy var birthdayLabel: TapAnimationLabel = {
        let label = TapAnimationLabel(text: "생일")
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(birthdayLabelDidTap))
        label.addGestureRecognizer(tapGesture)
        return label
    }()
    
    private lazy var levelLabel: TapAnimationLabel = {
        let label = TapAnimationLabel(text: "레벨")
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(levelLabelDidTap))
        label.addGestureRecognizer(tapGesture)
        return label
    }()
    
    private let displayNickNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = .lightGray
        return label
    }()
    
    private let displayBirthdayLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = .lightGray
        return label
    }()
    
    private let displayLevelLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = .lightGray
        return label
    }()
    
    private lazy var saveButton: UIButton = {
        var titleContainer = AttributeContainer()
        titleContainer.font = UIFont.boldSystemFont(ofSize: 20)
        
        var configuration = UIButton.Configuration.filled()
        configuration.attributedTitle = AttributedString("저장하기", attributes: titleContainer)
        
        let button = UIButton(configuration: configuration)
        button.addTarget(self, action: #selector(saveButtonDidTap), for: .touchUpInside)
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
        configureNotification()
        configureDisplayLabel()
    }
    
    private func configureView() {
        view.backgroundColor = .white
    }
    
    private func configureHierarchy() {
        view.addSubviews(
            nickNameLabel,
            birthdayLabel,
            levelLabel,
            displayNickNameLabel,
            displayBirthdayLabel,
            displayLevelLabel,
            saveButton,
            withdrawButton
        )
    }
    
    private func configureLayout() {
        nickNameLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(60)
            $0.height.equalTo(60)
            $0.centerX.equalToSuperview().offset(-90)
        }
        
        birthdayLabel.snp.makeConstraints {
            $0.top.equalTo(nickNameLabel.snp.bottom).offset(30)
            $0.height.equalTo(60)
            $0.centerX.equalToSuperview().offset(-90)
        }
        
        levelLabel.snp.makeConstraints {
            $0.top.equalTo(birthdayLabel.snp.bottom).offset(30)
            $0.height.equalTo(60)
            $0.centerX.equalToSuperview().offset(-90)
        }
        
        displayNickNameLabel.snp.makeConstraints {
            $0.centerY.equalTo(nickNameLabel)
            $0.leading.equalTo(nickNameLabel.snp.trailing).offset(30)
        }
        
        displayBirthdayLabel.snp.makeConstraints {
            $0.centerY.equalTo(birthdayLabel)
            $0.leading.equalTo(nickNameLabel.snp.trailing).offset(30)
        }
        
        displayLevelLabel.snp.makeConstraints {
            $0.centerY.equalTo(levelLabel)
            $0.leading.equalTo(nickNameLabel.snp.trailing).offset(30)
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
    
    private func configureNotification() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(nickNameTextFieldDidChange),
            name: NSNotification.Name("nickNameTextFieldDidChange"),
            object: nil
        )
    }
    
    private func configureDisplayLabel() {
        let nickNameText = UserDefaults.standard.string(forKey: "nickName") ?? "NO NAME"
        let birthdayText = UserDefaults.standard.string(forKey: "birthday") ?? "NO Date"
        let levelText = UserDefaults.standard.string(forKey: "level") ?? "NO Level"
        
        displayNickNameLabel.text = nickNameText
        displayBirthdayLabel.text = birthdayText
        displayLevelLabel.text = levelText
    }
    
    @objc private func nickNameTextFieldDidChange(_ notification: NSNotification) {
        guard let newNickName = notification.userInfo?["nickName"] as? String else { return }
        displayNickNameLabel.text = newNickName
        isNickNameEnter = true
    }
    
    @objc private func nickNameLabelDidTap(_ sender: UITapGestureRecognizer) {
        let nickNameViewController = NickNameViewController()
        
        if isNickNameEnter {
            nickNameViewController.nickNameTextField.text = displayNickNameLabel.text
        }
        
        navigationController?.pushViewController(nickNameViewController, animated: true)
    }
    
    @objc private func birthdayLabelDidTap(_ sender: UITapGestureRecognizer) {
        let birthdayViewController = BirthdayViewController()
        birthdayViewController.closure = { [weak self] date in
            let dateString = self?.dateformatter.string(from: date)
            
            self?.displayBirthdayLabel.text = dateString
            self?.isBirthdayEnter = true
        }
        
        if isBirthdayEnter {
            let dateString = displayLevelLabel.text ?? ""
            let date = dateformatter.date(from: dateString) ?? Date()
            birthdayViewController.birthdayDatePicker.date = date
        }
        
        navigationController?.pushViewController(birthdayViewController, animated: true)
    }
    
    @objc private func levelLabelDidTap(_ sender: UITapGestureRecognizer) {
        let levelViewController = LevelViewController()
        levelViewController.delegate = self
        
        if isLevelEnter {
            let selectedIndex = levelViewController.levelTitleArray.firstIndex(of: displayLevelLabel.text ?? "") ?? 0
            levelViewController.levelSegmentedControl.selectedSegmentIndex = selectedIndex
        }
        
        navigationController?.pushViewController(levelViewController, animated: true)
    }
    
    @objc private func saveButtonDidTap(_ sender: UIButton) {
        UserDefaults.standard.set(displayNickNameLabel.text, forKey: "nickName")
        UserDefaults.standard.set(displayBirthdayLabel.text, forKey: "birthday")
        UserDefaults.standard.set(displayLevelLabel.text, forKey: "level")
        presentAlert(title: "저장성공")
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

// MARK: - LevelViewControllerDelegate
extension ProfileViewController: LevelViewControllerDelegate {
    
    func didChangeValue(value: String) {
        displayLevelLabel.text = value
        isLevelEnter = true
    }
}
