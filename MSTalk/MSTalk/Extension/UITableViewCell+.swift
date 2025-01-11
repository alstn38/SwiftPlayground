//
//  UITableViewCell+.swift
//  MSTalk
//
//  Created by 강민수 on 1/10/25.
//

import UIKit

extension UITableViewCell: ReusableViewProtocol {
    
    static var identifier: String {
        return String(describing: self)
    }
}
