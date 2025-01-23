//
//  BirthdayViewController.swift
//  MSValueTransfer
//
//  Created by 강민수 on 1/23/25.
//

import SnapKit
import UIKit

final class BirthdayViewController: UIViewController {
    
    var closure: ((Date) -> Void)?
    
    let birthdayDatePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .date
        return datePicker
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
        
        closure?(birthdayDatePicker.date)
    }
    
    private func configureView() {
        view.backgroundColor = .white
    }
    
    private func configureHierarchy() {
        view.addSubviews(
            birthdayDatePicker,
            confirmButton
        )
    }
    
    private func configureLayout() {
        birthdayDatePicker.snp.makeConstraints {
            $0.centerX.top.equalTo(view.safeAreaLayoutGuide)
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
