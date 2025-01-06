//
//  MagazineTableViewCell.swift
//  MSTravel
//
//  Created by 강민수 on 1/3/25.
//

import Kingfisher
import UIKit

final class MagazineTableViewCell: UITableViewCell {
    
    static let identifier: String = "MagazineTableViewCell"
    
    @IBOutlet var magazineImageView: UIImageView!
    @IBOutlet var magazineTitleLabel: UILabel!
    @IBOutlet var magazineSubtitle: UILabel!
    @IBOutlet var magazineDateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupCell()
    }
    
    func configureCell(_ magazine: Magazine) {
        if let url = URL(string: magazine.photo_image) {
            magazineImageView.kf.setImage(with: url)
        } else {
            magazineImageView.image = UIImage(systemName: "photo.artframe")
        }
        magazineTitleLabel.text = magazine.title
        magazineSubtitle.text = magazine.subtitle
        magazineDateLabel.text = magazine.date.formatToDate()
    }
    
    private func setupCell() {
        magazineImageView.contentMode = .scaleToFill
        magazineImageView.tintColor = .black
        magazineImageView.layer.cornerRadius = 10
        
        magazineTitleLabel.font = .systemFont(ofSize: 16, weight: .bold)
        magazineTitleLabel.textColor = .black
        magazineTitleLabel.numberOfLines = 2
        
        magazineSubtitle.font = .systemFont(ofSize: 13, weight: .medium)
        magazineSubtitle.textColor = .gray
        magazineSubtitle.numberOfLines = 1
        
        magazineDateLabel.font = .systemFont(ofSize: 12, weight: .regular)
        magazineDateLabel.textColor = .gray
        magazineDateLabel.numberOfLines = 1
    }
}
