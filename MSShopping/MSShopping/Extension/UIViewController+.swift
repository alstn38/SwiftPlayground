//
//  UIViewController+.swift
//  MSShopping
//
//  Created by 강민수 on 1/16/25.
//

import UIKit

extension UIViewController {
    
    func presentAlert(title: String, message: String) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        
        let action = UIAlertAction(title: "확인", style: .default)
        alert.addAction(action)
        present(alert, animated: true)
    }
    
    func presentDefaultAlert(alertTitle: String) {
        let alert = UIAlertController(
            title: alertTitle,
            message: nil,
            preferredStyle: .alert
        )
        
        let action = UIAlertAction(title: "확인", style: .default)
        alert.addAction(action)
        present(alert, animated: true)
    }
    
    func presentDefaultAlert(alertTitle: String, completion: @escaping () -> Void) {
        let alert = UIAlertController(
            title: alertTitle,
            message: nil,
            preferredStyle: .alert
        )
        
        let action = UIAlertAction(title: "확인", style: .default) { _ in
            completion()
        }
        alert.addAction(action)
        present(alert, animated: true)
    }
}
