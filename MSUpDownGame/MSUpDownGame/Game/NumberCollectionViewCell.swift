//
//  NumberCollectionViewCell.swift
//  MSUpDownGame
//
//  Created by 강민수 on 1/9/25.
//

import UIKit

final class NumberCollectionViewCell: UICollectionViewCell {

    @IBOutlet private var numberBackgroundView: UIView!
    @IBOutlet private var numberLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupCell()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        numberBackgroundView.layer.cornerRadius = numberBackgroundView.frame.height / 2
    }
    
    func configureCell(text: String) {
        numberLabel.text = text
    }
    
    private func setupCell() {
        numberLabel.textColor = .black
        numberLabel.font = .systemFont(ofSize: 12, weight: .medium)
        numberLabel.textAlignment = .center
    }
}
