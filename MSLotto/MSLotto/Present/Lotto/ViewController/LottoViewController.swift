//
//  LottoViewController.swift
//  MSLotto
//
//  Created by 강민수 on 1/14/25.
//

import SnapKit
import UIKit

final class LottoViewController: UIViewController {
    
    private let lottoTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.textAlignment = .center
        textField.font = .systemFont(ofSize: 18, weight: .medium)
        return textField
    }()
    
    private let lottoNumberPickerView: UIPickerView = {
        let pickerView = UIPickerView()
        return pickerView
    }()
    
    private let numberGuideLabel: UILabel = {
        let label = UILabel()
        label.text = "당첨번호 안내"
        label.font = .systemFont(ofSize: 13, weight: .medium)
        return label
    }()
    
    private let drawDateLabel: UILabel = {
        let label = UILabel()
        label.text = "2020-05-30추첨" // TODO: 서버 연결시 제거
        label.font = .systemFont(ofSize: 12, weight: .medium)
        label.textColor = .lightGray
        return label
    }()
    
    private let lineView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray4
        return view
    }()
    
    private let winningLabelStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.spacing = 5
        stackView.alignment = .center
        return stackView
    }()
    
    private let winningNumberLabel: UILabel = {
        let label = UILabel()
        label.text = "913회" // TODO: 서버연결시 제거
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textColor = .systemGreen
        return label
    }()
    
    private let winningMessageLabel: UILabel = {
        let label = UILabel()
        label.text = "당첨결과"
        label.font = .systemFont(ofSize: 24, weight: .medium)
        label.textColor = .black
        return label
    }()
    
    private let drawBallStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        stackView.alignment = .center
        return stackView
    }()
    
    private let drawBallArray: [UIView] = {
        let ballColor: [UIColor] = [.yellow, .cyan, .cyan, .systemPink, .systemPink, .gray, .clear, .gray]
        let viewArray = ballColor.map { LottoResultBallView(backgroundColor: $0) }
        return viewArray
    }()
    
    private let bonusLabel: UILabel = {
        let label = UILabel()
        label.text = "보너스"
        label.font = .systemFont(ofSize: 11, weight: .medium)
        label.textColor = .gray
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    private func setupView() {
        view.backgroundColor = .white
        
        setupHierarchy()
        setupLayout()
    }
    
    private func setupHierarchy() {
        [lottoTextField, numberGuideLabel, drawDateLabel,
         lineView, winningLabelStackView, drawBallStackView, bonusLabel].forEach {
            view.addSubview($0)
        }
        
        drawBallArray.forEach {
            drawBallStackView.addArrangedSubview($0)
        }
        
        winningLabelStackView.addArrangedSubview(winningNumberLabel)
        winningLabelStackView.addArrangedSubview(winningMessageLabel)
    }
    
    private func setupLayout() {
        lottoTextField.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(30)
            $0.height.equalTo(40)
        }
        
        numberGuideLabel.snp.makeConstraints {
            $0.top.equalTo(lottoTextField.snp.bottom).offset(30)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
        }
        
        drawDateLabel.snp.makeConstraints {
            $0.centerY.equalTo(numberGuideLabel)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        lineView.snp.makeConstraints {
            $0.top.equalTo(numberGuideLabel.snp.bottom).offset(10)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.height.equalTo(1)
        }
        
        winningLabelStackView.snp.makeConstraints {
            $0.top.equalTo(lineView.snp.bottom).offset(30)
            $0.centerX.equalTo(view)
        }
        
        drawBallArray.forEach { drawBallView in
            drawBallView.snp.makeConstraints {
                $0.height.equalTo(drawBallView.snp.width)
            }
        }
        
        drawBallStackView.snp.makeConstraints {
            $0.top.equalTo(winningLabelStackView.snp.bottom).offset(30)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
    }
}
