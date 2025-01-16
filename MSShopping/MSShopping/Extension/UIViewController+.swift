//
//  UIViewController+.swift
//  MSShopping
//
//  Created by 강민수 on 1/16/25.
//

import UIKit

extension UIViewController {
    
    func presentWarningAlert(alertTitle: String) {
        let alert = UIAlertController(
            title: alertTitle,
            message: nil,
            preferredStyle: .alert
        )
        
        let action = UIAlertAction(title: "확인", style: .default)
        alert.addAction(action)
        present(alert, animated: true)
    }
}
