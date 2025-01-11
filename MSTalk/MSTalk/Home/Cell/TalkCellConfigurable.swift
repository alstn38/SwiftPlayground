//
//  TalkCellConfigurable.swift
//  MSTalk
//
//  Created by 강민수 on 1/11/25.
//

import UIKit

protocol TalkCellConfigurable: UICollectionViewCell {
    func configureCell(_ chatRoom: ChatRoom)
}
