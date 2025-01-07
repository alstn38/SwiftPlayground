//
//  PopularCityCollectionViewCell.swift
//  MSTravel
//
//  Created by 강민수 on 1/7/25.
//

import Kingfisher
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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        cityImageView.backgroundColor = .clear
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        cityImageView.layer.cornerRadius = cityImageView.frame.height / 2
    }
    
    func configureCell(_ cityInfo: City, searchText: String) {
        if let url = URL(string: cityInfo.city_image) {
            cityImageView.kf.setImage(with: url)
        } else {
            cityImageView.backgroundColor = .gray
        }
        
        cityNameLabel.text = cityInfo.displayCityName
        cityDescriptionLabel.text = cityInfo.city_explain
        highlightSearchedLabelText(cityNameLabel, searchedText: searchText)
        highlightSearchedLabelText(cityDescriptionLabel, searchedText: searchText)
    }
    
    /// Label의 검색된 Text를 highlight하는 메서드
    private func highlightSearchedLabelText(_ label: UILabel, searchedText: String) {
        guard let labelText = label.text else { return }
        guard let searchedRange = labelText.range(of: searchedText, options: .caseInsensitive) else { return }
        let nsRange = NSRange(searchedRange, in: labelText)
        let attributedString = NSMutableAttributedString(string: labelText)
        attributedString.addAttribute(.foregroundColor, value: UIColor.systemBlue, range: nsRange)
        label.attributedText = attributedString
    }
    
    private func setupCell() {
        cityImageView.contentMode = .scaleToFill
        
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
