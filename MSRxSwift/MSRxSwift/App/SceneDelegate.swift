//
//  SceneDelegate.swift
//  MSRxSwift
//
//  Created by 강민수 on 2/18/25.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        let mainViewController = MainViewController()
        let mainNavigationController = UINavigationController(rootViewController: mainViewController)
        window = UIWindow(windowScene: scene)
        window?.rootViewController = mainNavigationController
        window?.makeKeyAndVisible()
    }
}
