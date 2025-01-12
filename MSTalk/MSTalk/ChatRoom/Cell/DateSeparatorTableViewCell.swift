//
//  DateSeparatorTableViewCell.swift
//  MSTalk
//
//  Created by 강민수 on 1/12/25.
//

import UIKit

final class DateSeparatorTableViewCell: UITableViewCell {

    @IBOutlet private var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupCell()
    }
    
    private func setupCell() {
        dateLabel.textColor = .black
        dateLabel.font = .systemFont(ofSize: 12, weight: .regular)
        dateLabel.textAlignment = .center
        dateLabel.numberOfLines = 1
    }
}

// MARK: - ChatCellConfigurable
extension DateSeparatorTableViewCell: ChatCellConfigurable {
    
    func configureChatCell(_ chat: Chat) {
        dateLabel.text = DateFormatterManager.shared.convertDateString(with: chat.date)
    }
}
