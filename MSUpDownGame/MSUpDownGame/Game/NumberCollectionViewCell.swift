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
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        numberBackgroundView.layer.cornerRadius = numberBackgroundView.frame.height / 2
    }
}
