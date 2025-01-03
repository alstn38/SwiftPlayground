//
//  MagazineTableViewCell.swift
//  MSTravel
//
//  Created by 강민수 on 1/3/25.
//

import UIKit

final class MagazineTableViewCell: UITableViewCell {
    
    @IBOutlet var magazineImageView: UIImageView!
    @IBOutlet var magazineTitleLabel: UILabel!
    @IBOutlet var magazineSubtitle: UILabel!
    @IBOutlet var magazineDateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupCell()
    }
    
    func configureCell(_ magazine: Magazine) {
        magazineTitleLabel.text = magazine.title
        magazineSubtitle.text = magazine.subtitle
        magazineDateLabel.text = magazine.date
    }
    
    private func setupCell() {
        magazineImageView.contentMode = .scaleToFill
        
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
