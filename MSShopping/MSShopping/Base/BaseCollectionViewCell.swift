//
//  BaseCollectionViewCell.swift
//  MSShopping
//
//  Created by 강민수 on 1/16/25.
//

import UIKit

class BaseCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupCell()
        setupHierarchy()
        setupLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCell() { }
    
    func setupHierarchy() { }
    
    func setupLayout() { }
}
