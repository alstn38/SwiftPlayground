//
//  LevelViewController.swift
//  MSValueTransfer
//
//  Created by 강민수 on 1/23/25.
//

import SnapKit
import UIKit

protocol LevelViewControllerDelegate {
    func didChangeValue(value: String)
}

final class LevelViewController: UIViewController {
    
    var delegate: LevelViewControllerDelegate?
    
    let levelTitleArray: [String] = ["상", "중", "하"]
    lazy var levelSegmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: levelTitleArray)
        segmentedControl.selectedSegmentIndex = 0
        return segmentedControl
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
        
        let selectedIndex = levelSegmentedControl.selectedSegmentIndex
        let level = levelTitleArray[selectedIndex]
        delegate?.didChangeValue(value: level)
    }
    
    private func configureView() {
        view.backgroundColor = .white
    }
    
    private func configureHierarchy() {
        view.addSubviews(
            levelSegmentedControl,
            confirmButton
        )
    }
    
    private func configureLayout() {
        levelSegmentedControl.snp.makeConstraints {
            $0.centerX.top.equalTo(view.safeAreaLayoutGuide)
            $0.width.equalTo(view.safeAreaLayoutGuide).inset(24)
        }
        
        confirmButton.snp.makeConstraints {
            $0.bottom.equalTo(view.keyboardLayoutGuide).inset(30)
            $0.height.equalTo(60)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(40)
        }
    }
    
    @objc private func confirmButtonDidTap(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}
