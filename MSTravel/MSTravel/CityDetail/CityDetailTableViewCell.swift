//
//  CityDetailTableViewCell.swift
//  MSTravel
//
//  Created by 강민수 on 1/3/25.
//

import Kingfisher
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
    
    func configureCell(_ travel: Travel, tag: Int) {
        cityNameLabel.text = travel.title
        cityDescriptionLabel.text = travel.description
        cityLikeButton.isSelected = travel.like ?? false
        cityLikeButton.tag = tag
        
        let saveCount = travel.save ?? 0
        saveCountLabel.text = "(3) · 저장 \(saveCount.formatToDecimalNumber())"
        
        guard let travelImage = travel.travel_image else {
            return cityImageView.image = UIImage(systemName: "photo.artframe")
        }
        
        if let imageURL = URL(string: travelImage) {
            cityImageView.kf.setImage(with: imageURL)
        } else {
            cityImageView.image = UIImage(systemName: "photo.artframe")
        }
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
        cityImageView.tintColor = .black
        
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
