//
//  SceneDelegate.swift
//  MSWalkMemoryPractice
//
//  Created by 강민수 on 3/17/25.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let initialViewController = storyboard.instantiateInitialViewController()

        window = UIWindow(windowScene: scene)
        window?.rootViewController = initialViewController
        window?.makeKeyAndVisible()

    }
}
