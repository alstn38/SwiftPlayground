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
    
    @IBAction func numberTextFieldDidChange(_ sender: UITextField) {
        guard let inputNumber = Int(sender.text ?? "") else {
            gameStartButtonIsEnabled(false)
            return
        }
        
        gameStartButtonIsEnabled(true)
    }
    
    @IBAction private func viewDidTap(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
}
