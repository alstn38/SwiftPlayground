//
//  UIViewController+.swift
//  MSValueTransfer
//
//  Created by 강민수 on 1/23/25.
//

import UIKit

extension UIViewController {
    
    func presentAlert(title: String) {
        let alert = UIAlertController(
            title: title,
            message: nil,
            preferredStyle: .alert
        )
        
        let action = UIAlertAction(
            title: "확인",
            style: .default
        )
        
        alert.addAction(action)
        present(alert, animated: true)
    }
}
