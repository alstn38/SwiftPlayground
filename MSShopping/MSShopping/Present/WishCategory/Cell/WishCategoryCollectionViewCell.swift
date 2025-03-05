//
//  WishCategoryCollectionViewCell.swift
//  MSShopping
//
//  Created by 강민수 on 3/5/25.
//

import UIKit
import SnapKit

final class WishCategoryCollectionViewCell: BaseCollectionViewCell {
    
    private let folderName = UILabel()
    private let contentCount = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(_ item: WishCategory) {
        folderName.text = item.folderName
        contentCount.text = "\(item.detail.count)개"
    }
    
    override func setupCell() {
        contentView.backgroundColor = .black
        
        folderName.font = .systemFont(ofSize: 20, weight: . bold)
        folderName.textColor = .white
        
        contentCount.font = .systemFont(ofSize: 18, weight: . medium)
        contentCount.textColor = .white
    }
    
    override func setupHierarchy() {
        [folderName, contentCount].forEach {
            contentView.addSubview($0)
        }
    }
    
    override func setupLayout() {
        folderName.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(10)
        }
        
        contentCount.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(10)
        }
    }
}
