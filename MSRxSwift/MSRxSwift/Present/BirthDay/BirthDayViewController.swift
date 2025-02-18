//
//  BirthDayViewController.swift
//  MSRxSwift
//
//  Created by 강민수 on 2/18/25.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class BirthDayViewController: UIViewController {

    let birthDayPicker = UIDatePicker()
    let infoLabel = UILabel()
    let containerStackView = UIStackView()
    let yearLabel = UILabel()
    let monthLabel = UILabel()
    let dayLabel = UILabel()
    let nextButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
        configureHierarchy()
        configureLayout()
    }
    
    private func configureView() {
        view.backgroundColor = .white
        
        birthDayPicker.datePickerMode = .date
        birthDayPicker.preferredDatePickerStyle = .wheels
        birthDayPicker.locale = Locale(identifier: "ko-KR")
        birthDayPicker.maximumDate = Date()
        
        infoLabel.textColor = .black
        infoLabel.text = "만 17세 이상만 가입 가능합니다."
        
        containerStackView.axis = .horizontal
        containerStackView.distribution = .equalSpacing
        containerStackView.spacing = 10
        
        yearLabel.text = "2023년"
        yearLabel.textColor = .black
        
        monthLabel.text = "33월"
        monthLabel.textColor = .black
        
        dayLabel.text = "99일"
        dayLabel.textColor = .black
        
        nextButton.setTitle("가입하기", for: .normal)
        nextButton.setTitleColor(.white, for: .normal)
        nextButton.backgroundColor = .black
        nextButton.layer.cornerRadius = 10
    }
    
    private func configureHierarchy() {
        view.addSubview(birthDayPicker)
        view.addSubview(infoLabel)
        view.addSubview(containerStackView)
        view.addSubview(yearLabel)
        view.addSubview(monthLabel)
        view.addSubview(dayLabel)
        view.addSubview(nextButton)
    }
    
    private func configureLayout() {
        infoLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(150)
            $0.centerX.equalToSuperview()
        }
        
        containerStackView.snp.makeConstraints {
            $0.top.equalTo(infoLabel.snp.bottom).offset(30)
            $0.centerX.equalToSuperview()
        }
        
        [yearLabel, monthLabel, dayLabel].forEach {
            containerStackView.addArrangedSubview($0)
            
            $0.snp.makeConstraints {
                $0.width.equalTo(100)
            }
        }
        
        birthDayPicker.snp.makeConstraints {
            $0.top.equalTo(containerStackView.snp.bottom)
            $0.centerX.equalToSuperview()
        }
   
        nextButton.snp.makeConstraints {
            $0.height.equalTo(50)
            $0.top.equalTo(birthDayPicker.snp.bottom).offset(30)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
    }
}
