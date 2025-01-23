//
//  SceneDelegate.swift
//  MSValueTransfer
//
//  Created by 강민수 on 1/23/25.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let viewController = getInitViewController()
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = UINavigationController(rootViewController: viewController)
        window?.makeKeyAndVisible()
    }
    
    private func getInitViewController() -> UIViewController {
        let isOnboardExperience = UserDefaults.standard.bool(forKey: "isOnboardExperience")
        
        switch isOnboardExperience {
        case true:
            return ProfileViewController()
        case false:
            return OnboardingViewController()
        }
    }
}
