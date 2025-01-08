//
//  GameCollectionViewCell.swift
//  MSMiniGame
//
//  Created by 강민수 on 1/8/25.
//

import UIKit

final class GameCollectionViewCell: UICollectionViewCell {

    @IBOutlet private var numberLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupCell()
    }
    
    func configureCell(_ number: String) {
        numberLabel.text = number
    }
    
    private func setupCell() {
        numberLabel.font = .systemFont(ofSize: 12, weight: .regular)
        numberLabel.numberOfLines = 1
        numberLabel.textAlignment = .center
    }
}
