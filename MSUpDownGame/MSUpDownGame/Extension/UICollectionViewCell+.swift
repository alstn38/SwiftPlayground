//
//  UICollectionViewCell+.swift
//  MSUpDownGame
//
//  Created by 강민수 on 1/9/25.
//

import UIKit

extension UICollectionViewCell: ReusableViewProtocol {
    
    static var identifier: String {
        return String(describing: self)
    }
}
