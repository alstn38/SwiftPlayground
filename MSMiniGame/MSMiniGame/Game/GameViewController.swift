//
//  GameViewController.swift
//  MSMiniGame
//
//  Created by 강민수 on 1/8/25.
//

import UIKit

final class GameViewController: UIViewController {
    
    @IBOutlet private var gameTitleLabel: UILabel!
    @IBOutlet private var maxNumTextField: UITextField!
    @IBOutlet private var gameResultCollectionView: UICollectionView!
    @IBOutlet private var totalClapCountLabel: UILabel!
    private var maxNumPickerView = UIPickerView()
    private let gameManager: ThreeSixNineGameProtocol = GameManager(maxNumber: 10000)
    private let maxNumber: Int = 10000
    private var gameResultNumberArray: [String] = [] {
        didSet {
            gameResultCollectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupCollectionView()
    }
    
    /// 뷰의 속성을 정의하는 메서드
    private func setupView() {
        gameTitleLabel.text = "369 게임"
        gameTitleLabel.textColor = .black
        gameTitleLabel.textAlignment = .center
        gameTitleLabel.numberOfLines = 1
        gameTitleLabel.font = .boldSystemFont(ofSize: 30)
        
        maxNumTextField.placeholder = "최대 숫자를 입력해주세요"
        maxNumTextField.borderStyle = .line
        maxNumTextField.tintColor = .clear
        maxNumTextField.textAlignment = .center
        maxNumTextField.font = .systemFont(ofSize: 24, weight: .regular)
        maxNumTextField.inputView = maxNumPickerView
        
        totalClapCountLabel.font = .boldSystemFont(ofSize: 32)
        totalClapCountLabel.numberOfLines = 0
        totalClapCountLabel.textAlignment = .center
        
        maxNumPickerView.delegate = self
        maxNumPickerView.dataSource = self
    }
    
    /// 게임 ColelctionView의 속성을 정의하는 메서드
    private func setupCollectionView() {
        gameResultCollectionView.delegate = self
        gameResultCollectionView.dataSource = self
        
        let uiNib = UINib(nibName: GameCollectionViewCell.identifier, bundle: nil)
        gameResultCollectionView.register(uiNib, forCellWithReuseIdentifier: GameCollectionViewCell.identifier)
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let horizontalConstant: CGFloat = 20
        let minimumInteritemSpacing: CGFloat = 10
        let rowItemCount = 6
        let collectionViewWidth: CGFloat = UIScreen.main.bounds.width - (horizontalConstant * 2)
        let totalMinimumInteritemSpacing: CGFloat = minimumInteritemSpacing * CGFloat(rowItemCount - 1)
        let length: CGFloat = (collectionViewWidth - totalMinimumInteritemSpacing) / CGFloat(rowItemCount)
        
        layout.minimumLineSpacing = minimumInteritemSpacing
        layout.minimumInteritemSpacing = 10
        layout.itemSize = CGSize(width: length, height: length)
        layout.sectionInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        
        gameResultCollectionView.collectionViewLayout = layout
    }
    
    /// 게임 결과 Label의 Text를 변경하는 메서드
    private func changeTotalClapLabel(selectedNum: Int, totalClapCount: Int) {
        totalClapCountLabel.text = "숫자 \(selectedNum)까지 총 박수는 \(totalClapCount)번 입니다."
    }
    
    @IBAction private func viewDidTap(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
}

extension GameViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gameResultNumberArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let item = collectionView.dequeueReusableCell(
            withReuseIdentifier: GameCollectionViewCell.identifier,
            for: indexPath
        ) as? GameCollectionViewCell else { return UICollectionViewCell() }
        
        item.configureCell(gameResultNumberArray[indexPath.row])
        
        return item
    }
}

extension GameViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return maxNumber
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(row + 1)
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedNumber = row + 1
        maxNumTextField.text = String(selectedNumber)
        
        let totalClapCount = gameManager.getTotalClapCount(selectedNumber: selectedNumber)
        changeTotalClapLabel(selectedNum: selectedNumber, totalClapCount: totalClapCount)
        gameResultNumberArray = gameManager.getGameResultArray(selectedNumber: selectedNumber)
    }
}
