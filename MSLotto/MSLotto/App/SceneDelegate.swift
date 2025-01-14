//
//  SceneDelegate.swift
//  MSLotto
//
//  Created by 강민수 on 1/14/25.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: scene)
        window?.rootViewController = LottoViewController()
        window?.makeKeyAndVisible()
    }
}
