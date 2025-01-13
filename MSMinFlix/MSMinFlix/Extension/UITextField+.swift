//
//  UITextField+.swift
//  MSMinFlix
//
//  Created by 강민수 on 1/13/25.
//

import UIKit

extension UITextField {
    
    func setPlaceholder(placeholder: String, color: UIColor) {
        attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [.foregroundColor: color])
    }
}
