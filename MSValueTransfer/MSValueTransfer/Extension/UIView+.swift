//
//  UIView+.swift
//  MSValueTransfer
//
//  Created by 강민수 on 1/23/25.
//

import UIKit

extension UIView {
    
    func addSubviews(_ views: UIView...) {
        views.forEach {
            self.addSubview($0)
        }
    }
}
