//
//  CityDetailTableViewCell.swift
//  MSTravel
//
//  Created by 강민수 on 1/3/25.
//

import UIKit

final class CityDetailTableViewCell: UITableViewCell {

    @IBOutlet var cityNameLabel: UILabel!
    @IBOutlet var cityDescriptionLabel: UILabel!
    @IBOutlet var gradeStarImageViewArray: [UIImageView]!
    @IBOutlet var saveCountLabel: UILabel!
    @IBOutlet var cityImageView: UIImageView!
    @IBOutlet var cityLikeButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupCell()
        setupGradeStarImageView()
    }
    
    private func setupCell() {
        cityNameLabel.font = .boldSystemFont(ofSize: 14)
        cityNameLabel.textColor = .black
        cityNameLabel.numberOfLines = 1
        
        cityDescriptionLabel.font = .systemFont(ofSize: 13, weight: .medium)
        cityDescriptionLabel.textColor = .darkGray
        cityDescriptionLabel.numberOfLines = 1
        
        saveCountLabel.font = .systemFont(ofSize: 12, weight: .regular)
        saveCountLabel.textColor = .gray
        saveCountLabel.numberOfLines = 1
        
        cityImageView.contentMode = .scaleToFill
        cityImageView.layer.cornerRadius = 10
        
        cityLikeButton.setImage(UIImage(systemName: "heart"), for: .normal)
        cityLikeButton.setImage(UIImage(systemName: "heart.fill"), for: .selected)
        cityLikeButton.tintColor = .systemPink
    }
    
    private func setupGradeStarImageView() {
        for image in gradeStarImageViewArray {
            image.image = UIImage(systemName: "star.fill")
            image.tintColor = .systemYellow
            image.contentMode = .scaleToFill
        }
    }
}
