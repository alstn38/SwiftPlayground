//
//  GameViewController.swift
//  MSUpDownGame
//
//  Created by 강민수 on 1/9/25.
//

import UIKit

final class HomeViewController: UIViewController {
    
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var subTitleLabel: UILabel!
    @IBOutlet private var gameImageView: UIImageView!
    @IBOutlet private var numberTextField: UITextField!
    @IBOutlet private var textFieldLineView: UIView!
    @IBOutlet private var gameStartButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    private func setupView() {
        view.backgroundColor = UIColor(resource: .gameBackground)
        
        titleLabel.text = "UP DOWN"
        titleLabel.textColor = .black
        titleLabel.font = .boldSystemFont(ofSize: 40)
        titleLabel.textAlignment = .center
        
        subTitleLabel.text = "GAME"
        subTitleLabel.textColor = .black
        subTitleLabel.font = .systemFont(ofSize: 24, weight: .medium)
        subTitleLabel.textAlignment = .center
        
        gameImageView.image = UIImage(resource: .emotion1)
        gameImageView.contentMode = .scaleToFill
        
        numberTextField.borderStyle = .none
        numberTextField.placeholder = "최대 숫자를 입력해주세요."
        numberTextField.font = .systemFont(ofSize: 30, weight: .bold)
        numberTextField.keyboardType = .numberPad
        numberTextField.textAlignment = .center
        
        textFieldLineView.backgroundColor = .white
        
        gameStartButton.setTitle("시작하기", for: .normal)
        gameStartButton.setTitleColor(.white, for: .normal)
        gameStartButton.titleLabel?.font = .boldSystemFont(ofSize: 18)
        gameStartButton.isEnabled = false
        gameStartButton.backgroundColor = .gray
        gameStartButton.layer.cornerRadius = 10
        gameStartButton.clipsToBounds = true
    }
    
    private func gameStartButtonIsEnabled(_ possible: Bool) {
        let backgroundColor = possible ? UIColor.black : UIColor.gray
        gameStartButton.backgroundColor = backgroundColor
        gameStartButton.isEnabled = possible
    }
    
    /// 입력된 숫자가 변경되었을 때 호출되는 메서드
    @IBAction func numberTextFieldDidChange(_ sender: UITextField) {
        guard let inputNumber = Int(sender.text ?? "") else {
            gameStartButtonIsEnabled(false)
            return
        }
        
        guard inputNumber > 0 else {
            sender.text = nil
            gameStartButtonIsEnabled(false)
            presentAlert(alertTitle: "숫자는 0보다 커야합니다.", actionTitle: "확인")
            return
        }
        
        guard inputNumber <= 300 else {
            sender.text = nil
            gameStartButtonIsEnabled(false)
            presentAlert(alertTitle: "숫자는 300이하로 입력해주세요.", actionTitle: "확인")
            return
        }
        
        gameStartButtonIsEnabled(true)
    }
    
    /// 게임 시작하기 버튼을 클릭했을 때 호출되는 메서드
    @IBAction func gameStartButtonDidTap(_ sender: UIButton) {
        guard let inputNumber = Int(numberTextField.text ?? "") else { return }
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let identifier = String(describing: GameViewController.self)
        let gameManager: GameManagerProtocol = GameManager(maxNumber: inputNumber)
        
        guard let viewController = storyboard.instantiateViewController(withIdentifier: identifier) as? GameViewController else { return
        }
        
        viewController.gameManager = gameManager
        viewController.modalPresentationStyle = .fullScreen
        viewController.modalTransitionStyle = .crossDissolve
        
        present(viewController, animated: true)
    }
    
    @IBAction private func viewDidTap(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
}
