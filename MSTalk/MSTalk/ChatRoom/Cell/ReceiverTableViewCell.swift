//
//  ReceiverTableViewCell.swift
//  MSTalk
//
//  Created by 강민수 on 1/10/25.
//

import UIKit

final class ReceiverTableViewCell: UITableViewCell {
    
    @IBOutlet private var profileImageView: UIImageView!
    @IBOutlet private var chatBackgroundView: UIView!
    @IBOutlet private var chatMessageLabel: UILabel!
    @IBOutlet private var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupCell()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        profileImageView.layer.cornerRadius = profileImageView.frame.height / 2
    }

    private func setupCell() {
        profileImageView.contentMode = .scaleAspectFit
        profileImageView.tintColor = .black
        
        chatBackgroundView.backgroundColor = .white
        chatBackgroundView.layer.cornerRadius = 10
        chatBackgroundView.layer.borderWidth = 1
        chatBackgroundView.layer.borderColor = UIColor.black.cgColor
        
        chatMessageLabel.font = .systemFont(ofSize: 12, weight: .regular)
        chatMessageLabel.textColor = .black
        chatMessageLabel.numberOfLines = 0
        
        dateLabel.font = .systemFont(ofSize: 11, weight: .regular)
        dateLabel.textColor = .lightGray
        dateLabel.numberOfLines = 1
    }
}

// MARK: - ChatCellConfigurable
extension ReceiverTableViewCell: ChatCellConfigurable {
    
    func configureChatCell(_ chat: Chat) {
        let profileImage = UIImage(named: chat.user.rawValue) ?? UIImage(systemName: "person.fill")
        profileImageView.image = profileImage
        chatMessageLabel.text = chat.message
        dateLabel.text = DateFormatterManager.shared.convertTimeString(chat.date)
    }
}
