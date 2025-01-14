//
//  LottoViewController.swift
//  MSLotto
//
//  Created by 강민수 on 1/14/25.
//

import Alamofire
import SnapKit
import UIKit

final class LottoViewController: UIViewController {
    
    private lazy var lottoNumberArray: [Int] = Array(1...recentRound).reversed()
    
    private var recentRound: Int = {
        let systemCalendar = Calendar.autoupdatingCurrent
        let startDateComponents = DateComponents(year: 2002, month: 12, day: 07)
        guard let startDay = systemCalendar.date(from: startDateComponents) else { return 0 }
        let today = Calendar.current.startOfDay(for: Date())
        let differenceDay = systemCalendar.dateComponents([.day], from: startDay, to: today).day ?? 0
        let recentRound = Int(differenceDay / 7) + 1
        return recentRound
    }()
    
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
    
    private let roundNumberLabel: UILabel = {
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
        stackView.alpha = 0.0
        return stackView
    }()
    
    private let drawBallArray: [LottoResultBallView] = {
        let ballColor: [UIColor] = [.lottoYello, .lottoBlue, .lottoBlue, .lottoRed, .lottoRed, .lottoGray, .clear, .lottoGray]
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
    
    private let winnerMoneyLabel: UILabel = {
        let label = UILabel()
        label.text = "당첨금"
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupPickerView()
        lottoTextField.text = String(recentRound)
        getLottoResult(roundNumber: recentRound)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    private func setupPickerView() {
        lottoTextField.inputView = lottoNumberPickerView
        lottoNumberPickerView.delegate = self
        lottoNumberPickerView.dataSource = self
    }
    
    private func getLottoResult(roundNumber: Int) {
        let url = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=\(roundNumber)"
        
        AF.request(url, method: .get).responseDecodable(of: Lotto.self) { [weak self] response in
            
            switch response.result {
            case .success(let value):
                self?.configureLottoResult(value)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func configureLottoResult(_ lotto: Lotto) {
        drawBallStackView.alpha = 1.0
        drawDateLabel.text = "\(lotto.drawDate) 추첨"
        roundNumberLabel.text = "\(lotto.roundNumber)회"
        winnerMoneyLabel.text = "당첨금\n\(lotto.firstWinnerMoney.formatted())원"
        drawBallArray[0].configureView(lotto.drawNumber1.formatted())
        drawBallArray[1].configureView(lotto.drawNumber2.formatted())
        drawBallArray[2].configureView(lotto.drawNumber3.formatted())
        drawBallArray[3].configureView(lotto.drawNumber4.formatted())
        drawBallArray[4].configureView(lotto.drawNumber5.formatted())
        drawBallArray[5].configureView(lotto.drawNumber6.formatted())
        drawBallArray[6].configureView("+")
        drawBallArray[7].configureView(lotto.bonusNumber.formatted())
    }
    
    private func setupView() {
        view.backgroundColor = .white
        
        setupHierarchy()
        setupLayout()
    }
    
    private func setupHierarchy() {
        [lottoTextField, numberGuideLabel, drawDateLabel,
         lineView, winningLabelStackView, drawBallStackView,
         bonusLabel, winnerMoneyLabel].forEach {
            view.addSubview($0)
        }
        
        drawBallArray.forEach {
            drawBallStackView.addArrangedSubview($0)
        }
        
        winningLabelStackView.addArrangedSubview(roundNumberLabel)
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
        
        winnerMoneyLabel.snp.makeConstraints {
            $0.top.equalTo(drawBallStackView.snp.bottom).offset(100)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(30)
        }
    }
}

// MARK: - UIPickerViewDelegate, UIPickerViewDataSource
extension LottoViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return lottoNumberArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(lottoNumberArray[row])
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        lottoTextField.text = String(lottoNumberArray[row])
        getLottoResult(roundNumber: lottoNumberArray[row])
    }
}
