//
//  SenderTableViewCell.swift
//  MSTalk
//
//  Created by 강민수 on 1/10/25.
//

import UIKit

final class SenderTableViewCell: UITableViewCell {
    
    @IBOutlet private var chatBackgroundView: UIView!
    @IBOutlet private var chatMessageLabel: UILabel!
    @IBOutlet private var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupCell()
    }

    private func setupCell() {
        chatBackgroundView.backgroundColor = .white
        chatBackgroundView.layer.cornerRadius = 10
        chatBackgroundView.layer.borderWidth = 1
        chatBackgroundView.layer.borderColor = UIColor.black.cgColor
        chatBackgroundView.backgroundColor = .systemGray5
        
        chatMessageLabel.font = .systemFont(ofSize: 12, weight: .regular)
        chatMessageLabel.textColor = .black
        chatMessageLabel.numberOfLines = 0
        
        dateLabel.font = .systemFont(ofSize: 11, weight: .regular)
        dateLabel.textColor = .lightGray
        dateLabel.numberOfLines = 1
    }
}

// MARK: - ChatCellConfigurable
extension SenderTableViewCell: ChatCellConfigurable {
    
    func configureChatCell(_ chat: Chat) {
        chatMessageLabel.text = chat.message
        dateLabel.text = DateFormatterManager.shared.convertTimeString(chat.date)
    }
}
