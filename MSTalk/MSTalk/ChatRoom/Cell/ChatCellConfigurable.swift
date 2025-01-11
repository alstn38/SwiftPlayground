//
//  ChatCellConfigurable.swift
//  MSTalk
//
//  Created by 강민수 on 1/11/25.
//

import UIKit

protocol ChatCellConfigurable: UITableViewCell {
    func configureChatCell(_ chat: Chat)
}
