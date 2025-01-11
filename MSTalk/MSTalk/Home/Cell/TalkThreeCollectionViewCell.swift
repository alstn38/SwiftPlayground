//
//  TalkThreeCollectionViewCell.swift
//  MSTalk
//
//  Created by 강민수 on 1/11/25.
//

import UIKit

final class TalkThreeCollectionViewCell: UICollectionViewCell {

    @IBOutlet private var profileImageViewArray: [UIImageView]!
    @IBOutlet private var chatRoomNameLabel: UILabel!
    @IBOutlet private var chatMessageLabel: UILabel!
    @IBOutlet private var chatDateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupCell()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        for imageView in profileImageViewArray {
            imageView.layer.cornerRadius = imageView.frame.height / 2
        }
    }

    private func setupCell() {
        for imageView in profileImageViewArray {
            imageView.contentMode = .scaleAspectFit
            imageView.tintColor = .black
        }
        
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

// MARK: - TalkCellConfigurable
extension TalkThreeCollectionViewCell: TalkCellConfigurable {
    
    func configureCell(_ chatRoom: ChatRoom) {
        for index in 0..<profileImageViewArray.count {
            let image = UIImage(named: chatRoom.chatroomImage[index]) ?? UIImage(systemName: "person.fill")
            profileImageViewArray[index].image = image
        }
        chatRoomNameLabel.text = chatRoom.chatroomName
        chatMessageLabel.text = chatRoom.lastChatMessage
        chatDateLabel.text = DateFormatterManager.shared.convertDateString(chatRoom.lastChatDate)
    }
}
