//
//  UserCollectionViewCell.swift
//  MSRxSwift
//
//  Created by 강민수 on 2/19/25.
//

import UIKit
import SnapKit

final class UserCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "UserCollectionViewCell"
    
    private let label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(label)
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 13)
        label.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
        layer.cornerRadius = 8
        layer.borderWidth = 1
        layer.borderColor = UIColor.black.cgColor
    }
    
    func configureView(_ text: String) {
        label.text = text
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
