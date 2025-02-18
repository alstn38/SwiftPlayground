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

    private let disposeBag = DisposeBag()
    private let birthDayPicker = UIDatePicker()
    private let infoLabel = UILabel()
    private let containerStackView = UIStackView()
    private let yearLabel = UILabel()
    private let monthLabel = UILabel()
    private let dayLabel = UILabel()
    private let nextButton = UIButton()
    
    private var currentYear: Int {
        let date = Date()
        let components = Calendar.current.dateComponents([.year,], from: date)
        return components.year ?? 0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureBinding()
        configureView()
        configureHierarchy()
        configureLayout()
    }
    
    private func configureBinding() {
        birthDayPicker.rx.date
            .map { date -> (year: String, month: String, day: String) in
                let components = Calendar.current.dateComponents([.year, .month, .day], from: date)
                return (String(components.year ?? 0), String(components.month ?? 0), String(components.day ?? 0))
            }
            .bind(with: self) { owner, components in
                owner.yearLabel.text = components.year + "년"
                owner.monthLabel.text = components.month + "월"
                owner.dayLabel.text = components.day + "일"
            }
            .disposed(by: disposeBag)
        
        birthDayPicker.rx.date
            .withUnretained(self)
            .map { owner, date -> Bool in
                let components = Calendar.current.dateComponents([.year], from: date)
                let inputYear = components.year ?? owner.currentYear
                return owner.currentYear - inputYear > 17
            }
            .bind(to: nextButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        nextButton.rx.tap
            .bind(with: self) { owner, _ in
                let alertView = UIAlertController(
                    title: "RxExample",
                    message: "Welcome !!",
                    preferredStyle: .alert
                )
                alertView.addAction(UIAlertAction(title: "OK", style: .cancel))
                owner.present(alertView, animated: true)
            }
            .disposed(by: disposeBag)
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
        
        yearLabel.textColor = .black
        monthLabel.textColor = .black
        dayLabel.textColor = .black
        
        var configuration = UIButton.Configuration.filled()
        configuration.title = "가입하기"
        configuration.baseForegroundColor = .white
        configuration.baseBackgroundColor = .black
        nextButton.configuration = configuration
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
