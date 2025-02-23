//
//  PopularCityTableViewCell.swift
//  MSTravel
//
//  Created by 강민수 on 1/6/25.
//

import Kingfisher
import UIKit

final class PopularCityTableViewCell: UITableViewCell {
    
    static let identifier: String = "PopularCityTableViewCell"

    @IBOutlet var cellBackgroundView: UIView!
    @IBOutlet var cityImageView: UIImageView!
    @IBOutlet var cityNameLabel: UILabel!
    @IBOutlet var cityDescriptionBackgroundView: UIView!
    @IBOutlet var cityDescriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupCell()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        cityImageView.backgroundColor = .clear
    }
    
    func configureCell(_ city: City) {
        if let url = URL(string: city.city_image) {
            cityImageView.kf.setImage(with: url)
        } else {
            cityImageView.backgroundColor = UIColor(red: 255/255, green: 250/255, blue: 205/255, alpha: 1.0)
        }
        
        cityNameLabel.text = city.displayCityName
        cityDescriptionLabel.text = city.city_explain
    }
    
    private func setupCell() {
        cellBackgroundView.layer.cornerRadius = 15
        cellBackgroundView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMaxYCorner]
        cellBackgroundView.clipsToBounds = true
        
        // clipsToBounds로 인해서 그림자가 생성되지 않는 것으로 판단.
        // 하지만 clipsToBounds는 꼭 사용해야한다.
        // 새로운 그림자 View를 또 하나 새로 생성하는 방법이 적절할 것으로 판단.
//        cellBackgroundView.layer.shadowColor = UIColor.darkGray.cgColor
//        cellBackgroundView.layer.shadowOpacity = 0.5
//        cellBackgroundView.layer.shadowRadius = 1
        
        cityImageView.contentMode = .scaleToFill
        
        cityNameLabel.font = .boldSystemFont(ofSize: 17)
        cityNameLabel.textColor = .white
        cityNameLabel.numberOfLines = 1
        cityNameLabel.textAlignment = .right
        
        cityDescriptionBackgroundView.backgroundColor = .black
        cityDescriptionBackgroundView.alpha = 0.2
        
        cityDescriptionLabel.font = .systemFont(ofSize: 12, weight: .regular)
        cityDescriptionLabel.textColor = .white
        cityDescriptionLabel.numberOfLines = 0
    }
}
