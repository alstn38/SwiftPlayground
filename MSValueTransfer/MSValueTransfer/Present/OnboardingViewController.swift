//
//  OnboardingViewController.swift
//  MSValueTransfer
//
//  Created by 강민수 on 1/23/25.
//

import SnapKit
import UIKit

final class OnboardingViewController: UIViewController {
    
    private lazy var startButton: UIButton = {
        var titleContainer = AttributeContainer()
        titleContainer.font = UIFont.boldSystemFont(ofSize: 20)
        
        var configuration = UIButton.Configuration.filled()
        configuration.attributedTitle = AttributedString("시작하기", attributes: titleContainer)
        
        let button = UIButton(configuration: configuration)
        button.addTarget(self, action: #selector(startButtonDidTap), for: .touchUpInside)
        
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
        view.addSubview(startButton)
    }
    
    private func configureLayout() {
        startButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.height.equalTo(60)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(40)
        }
    }
    
    @objc private func startButtonDidTap(_ sender: UIButton) {
        print(#function)
        guard
            let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
            let window = windowScene.windows.first
        else { return }
        
        window.rootViewController = UINavigationController(rootViewController: ProfileViewController())
        window.makeKeyAndVisible()
    }
}
