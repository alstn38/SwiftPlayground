//
//  ShoppingTableViewCell.swift
//  MSTravel
//
//  Created by 강민수 on 1/4/25.
//

import UIKit

final class ShoppingTableViewCell: UITableViewCell {
    
    static let identifier: String = "ShoppingTableViewCell"

    @IBOutlet var shoppingBackgroundView: UIView!
    @IBOutlet var shoppingCheckButton: UIButton!
    @IBOutlet var shoppingListLabel: UILabel!
    @IBOutlet var shoppingLikeButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupCell()
    }
    
    func configureCell(_ shoppingCategory: ShoppingCategory, tag: Int) {
        shoppingListLabel.text = shoppingCategory.title
        
        let checkImage = shoppingCategory.isChecked
        ? UIImage(systemName: "checkmark.square.fill")
        : UIImage(systemName: "checkmark.square")
        
        let likeImage = shoppingCategory.isLiked
        ? UIImage(systemName: "star.fill")
        : UIImage(systemName: "star")
        
        shoppingCheckButton.setImage(checkImage, for: .normal)
        shoppingCheckButton.tag = tag
        
        shoppingLikeButton.setImage(likeImage, for: .normal)
        shoppingLikeButton.tag = tag
    }
    
    private func setupCell() {
        shoppingBackgroundView.backgroundColor = .systemGray5
        shoppingBackgroundView.layer.cornerRadius = 10
        
        shoppingCheckButton.tintColor = .black
        
        shoppingListLabel.font = .systemFont(ofSize: 12)
        
        shoppingLikeButton.tintColor = .black
    }
}
