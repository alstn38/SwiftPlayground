//
//  PopularCityCollectionViewCell.swift
//  MSTravel
//
//  Created by 강민수 on 1/7/25.
//

import UIKit

final class PopularCityCollectionViewCell: UICollectionViewCell {
    
    static let identifier: String = "PopularCityCollectionViewCell"

    @IBOutlet var cityImageView: UIImageView!
    @IBOutlet var cityNameLabel: UILabel!
    @IBOutlet var cityDescriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupCell()
    }
    
    private func setupCell() {
        cityImageView.contentMode = .scaleToFill
        cityImageView.layer.cornerRadius = cityImageView.frame.height / 2
        
        cityNameLabel.font = .systemFont(ofSize: 13, weight: .bold)
        cityNameLabel.textColor = .black
        cityNameLabel.numberOfLines = 1
        cityNameLabel.textAlignment = .center
        
        cityDescriptionLabel.font = .systemFont(ofSize: 12, weight: .regular)
        cityDescriptionLabel.textColor = .gray
        cityDescriptionLabel.numberOfLines = 2
        cityDescriptionLabel.textAlignment = .center
    }
}
