//
//  TalkCollectionViewCell.swift
//  MSTalk
//
//  Created by 강민수 on 1/10/25.
//

import UIKit

final class TalkCollectionViewCell: UICollectionViewCell {

    @IBOutlet private var profileImageView: UIImageView!
    @IBOutlet private var chatRoomNameLabel: UILabel!
    @IBOutlet private var chatMessageLabel: UILabel!
    @IBOutlet private var chatDateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupCell()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        profileImageView.layer.cornerRadius = profileImageView.frame.height / 2
    }
    
    private func setupCell() {
        profileImageView.contentMode = .scaleToFill
        
        chatRoomNameLabel.font = .boldSystemFont(ofSize: 12)
        chatRoomNameLabel.textColor = .black
        chatRoomNameLabel.numberOfLines = 1
        
        chatMessageLabel.font = .systemFont(ofSize: 12, weight: .regular)
        chatMessageLabel.textColor = .black
        chatMessageLabel.numberOfLines = 1
        
        chatDateLabel.font = .systemFont(ofSize: 11, weight: .regular)
        chatDateLabel.textColor = .gray
        chatDateLabel.textAlignment = .right
    }
}
