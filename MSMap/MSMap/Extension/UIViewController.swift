//
//  UIViewController.swift
//  MSMap
//
//  Created by 강민수 on 2/3/25.
//

import UIKit

extension UIViewController {
    
    func presentToSettingAppWithLocation() {
        let alertController = UIAlertController(
            title: "위치 서비스 사용",
            message: "위치서비스를 사용할 수 없습니다.\n기기의 \"설정 > 개인 정보 보호\"에서 위치서비스를 켜주세요.",
            preferredStyle: .alert
        )
        
        let goToSettingAlertAction = UIAlertAction(
            title: "설정으로 이동",
            style: .default
        ) { _ in
            guard let settingURL = URL(string: UIApplication.openSettingsURLString) else { return }
            UIApplication.shared.open(settingURL)
        }
        
        let cancelAlertAction = UIAlertAction(
            title: "취소",
            style: .cancel
        )
        
        alertController.addAction(goToSettingAlertAction)
        alertController.addAction(cancelAlertAction)
        present(alertController, animated: true)
    }
    
    func presentWarningAlert() {
        let alertController = UIAlertController(
            title: "위치 권한 오류",
            message: "위치 정보를 가져오기 위한 권한 요청에 실패했습니다. 잠시후 다시 시도해주세요.",
            preferredStyle: .alert
        )
        
        let alertAction = UIAlertAction(
            title: "확인",
            style: .default
        )
        
        alertController.addAction(alertAction)
        present(alertController, animated: true)
    }
    
    func presentWarningAlert(title: String, message: String) {
        let alertController = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        
        let alertAction = UIAlertAction(
            title: "확인",
            style: .default
        )
        
        alertController.addAction(alertAction)
        present(alertController, animated: true)
    }
}
