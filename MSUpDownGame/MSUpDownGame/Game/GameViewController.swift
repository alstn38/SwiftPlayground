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
    var sample: [Int] = Array(1...100)
    
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
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension GameViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sample.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: NumberCollectionViewCell.identifier,
            for: indexPath
        ) as? NumberCollectionViewCell else { return UICollectionViewCell() }
        
        return cell
    }
}
