//
//  BaseCollectionViewFlowLayout.swift
//  MSShopping
//
//  Created by 강민수 on 1/16/25.
//

import UIKit

final class BaseCollectionViewFlowLayout: UICollectionViewFlowLayout {
    
    init(
        cellCountOfRow: Int,
        insetSize: CGFloat,
        minimumSpacing: CGFloat,
        heightMultiply: CGFloat
    ) {
        super.init()
        
        let screenWidth: CGFloat = UIScreen.main.bounds.width
        let possibleCellLength: CGFloat = screenWidth - (insetSize * 2) - (minimumSpacing * (CGFloat(cellCountOfRow) - 1))
        let cellLength: CGFloat = possibleCellLength / CGFloat(cellCountOfRow)
        
        self.scrollDirection = .vertical
        self.minimumInteritemSpacing = minimumSpacing
        self.minimumLineSpacing = minimumSpacing
        self.sectionInset = UIEdgeInsets(top: insetSize, left: insetSize, bottom: insetSize, right: insetSize)
        self.itemSize = CGSize(width: cellLength, height: cellLength * heightMultiply)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
