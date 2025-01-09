//
//  GameViewController.swift
//  MSUpDownGame
//
//  Created by 강민수 on 1/9/25.
//

import UIKit

final class GameViewController: UIViewController {
    
    @IBOutlet private var gameStateTitle: UILabel!
    @IBOutlet private var tryCountLabel: UILabel!
    @IBOutlet private var numberCollectionView: UICollectionView!
    @IBOutlet private var confirmResultButton: UIButton!
    private var selectedNumber: Int?
    var gameManager: GameManagerProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupCollectionView()
    }
    
    private func setupView() {
        view.backgroundColor = UIColor(resource: .gameBackground)
        
        gameStateTitle.text = "UP DOWN"
        gameStateTitle.textColor = .black
        gameStateTitle.font = .boldSystemFont(ofSize: 40)
        gameStateTitle.textAlignment = .center
        
        tryCountLabel.text = "시도 횟수: 0"
        tryCountLabel.textColor = .black
        tryCountLabel.font = .systemFont(ofSize: 24, weight: .medium)
        tryCountLabel.textAlignment = .center
        
        confirmResultButton.setTitle("결과 확인하기", for: .normal)
        confirmResultButton.setTitleColor(.white, for: .normal)
        confirmResultButton.backgroundColor = .gray
        confirmResultButton.titleLabel?.font = .boldSystemFont(ofSize: 18)
        confirmResultButton.isEnabled = false
        confirmResultButton.layer.cornerRadius = 10
        confirmResultButton.clipsToBounds = true
    }
    
    private func setupCollectionView() {
        numberCollectionView.delegate = self
        numberCollectionView.dataSource = self
        
        let identifier = NumberCollectionViewCell.identifier
        let uiNib = UINib(nibName: identifier, bundle: nil)
        numberCollectionView.register(uiNib, forCellWithReuseIdentifier: identifier)
        
        let cellCountOfRow = 6
        let insetSize: CGFloat = 10
        let minimumSpacing: CGFloat = 10
        let screenWidth: CGFloat = view.window?.windowScene?.screen.bounds.width ?? UIScreen.main.bounds.width
        let possibleCellLength: CGFloat = screenWidth - (insetSize * 2) - (minimumSpacing * (CGFloat(cellCountOfRow) - 1))
        let cellLength: CGFloat = possibleCellLength / CGFloat(cellCountOfRow)
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = minimumSpacing
        layout.minimumLineSpacing = minimumSpacing
        layout.itemSize = CGSize(width: cellLength, height: cellLength)
        layout.sectionInset = UIEdgeInsets(top: insetSize, left: insetSize, bottom: insetSize, right: insetSize)
        
        numberCollectionView.collectionViewLayout = layout
        numberCollectionView.backgroundColor = .clear
    }
    
    private func confirmResultButtonIsEnabled(_ possible: Bool) {
        let backgroundColor = possible ? UIColor.black : UIColor.gray
        confirmResultButton.backgroundColor = backgroundColor
        confirmResultButton.isEnabled = possible
    }
    
    /// 결과 확인하기 버튼을 클릭했을 때 동작하는 메서드
    @IBAction private func confirmButtonDidTap(_ sender: UIButton) {
        guard let gameManager,
              let selectedNumber else { return }
        
        let gameStatus = gameManager.isCollectNumber(selectedNumber)
        
        if gameStatus.upDownStatus == .correct {
            presentAlert(alertTitle: "승리", actionTitle: "확인") { [weak self] _ in
                self?.dismiss(animated: true)
            }
        } else {
            gameStateTitle.text = gameStatus.upDownStatus.title
            tryCountLabel.text = gameStatus.tryCountDescription
            confirmResultButtonIsEnabled(false)
            numberCollectionView.reloadData()
        }
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension GameViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gameManager?.remainingNumberArray.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: NumberCollectionViewCell.identifier,
            for: indexPath
        ) as? NumberCollectionViewCell else { return UICollectionViewCell() }
        
        guard let remainingNumberArray = gameManager?.remainingNumberArray else {
            return UICollectionViewCell()
        }
        
        cell.configureCell(text: String(remainingNumberArray[indexPath.item]))
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? NumberCollectionViewCell,
              let remainingNumberArray = gameManager?.remainingNumberArray else {
            return
        }
        cell.numberCellIsSelected(true)
        confirmResultButtonIsEnabled(true)
        selectedNumber = remainingNumberArray[indexPath.item]
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? NumberCollectionViewCell else {
            return
        }
        cell.numberCellIsSelected(false)
    }
}
