//
//  AdvertisementTableViewCell.swift
//  MSTravel
//
//  Created by 강민수 on 1/4/25.
//

import UIKit

final class AdvertisementTableViewCell: UITableViewCell {

    @IBOutlet var advertisementBackgroundView: UIView!
    @IBOutlet var advertisementTitle: UILabel!
    @IBOutlet var badgeView: UIView!
    @IBOutlet var badgeLabel: UILabel!
    private let randomColorArray: [UIColor] = [
        UIColor(red: 255/255, green: 182/255, blue: 193/255, alpha: 1.0),
        UIColor(red: 189/255, green: 252/255, blue: 201/255, alpha: 1.0),
        UIColor(red: 173/255, green: 216/255, blue: 230/255, alpha: 1.0),
        UIColor(red: 230/255, green: 230/255, blue: 250/255, alpha: 1.0),
        UIColor(red: 255/255, green: 250/255, blue: 205/255, alpha: 1.0)
    ]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupCell()
    }
    
    func configureCell(_ travel: Travel) {
        advertisementTitle.text = travel.title
    }
    
    private func setupCell() {
        let randomColor = randomColorArray.randomElement() ?? .cyan
        
        advertisementBackgroundView.backgroundColor = randomColor
        advertisementBackgroundView.layer.cornerRadius = 15
        
        advertisementTitle.textColor = .black
        advertisementTitle.textAlignment = .center
        advertisementTitle.numberOfLines = 0
        advertisementTitle.font = .boldSystemFont(ofSize: 15)
        
        badgeView.backgroundColor = .systemGray6
        badgeView.layer.cornerRadius = 3
        
        badgeLabel.text = "AD"
        badgeLabel.textColor = .black
        badgeLabel.font = .systemFont(ofSize: 11, weight: .medium)
        badgeLabel.textAlignment = .center
    }
}
