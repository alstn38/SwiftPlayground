//
//  UIViewController+.swift
//  MSUpDownGame
//
//  Created by 강민수 on 1/9/25.
//

import UIKit

extension UIViewController {
    
    func presentAlert(
        alertTitle: String,
        alertMessage: String? = nil,
        actionTitle: String,
        actionHandler: ((UIAlertAction) -> Void)? = nil
    ) {
        let alertController = UIAlertController(
            title: alertTitle,
            message: alertMessage,
            preferredStyle: .alert
        )
        
        let alertAction = UIAlertAction(
            title: actionTitle,
            style: .default,
            handler: actionHandler
        )
        
        alertController.addAction(alertAction)
        
        present(alertController, animated: true)
    }
}
