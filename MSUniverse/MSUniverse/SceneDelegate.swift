//
//  SceneDelegate.swift
//  MSUniverse
//
//  Created by 강민수 on 2/11/25.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        
        let nasaViewModel = NasaViewModel()
        let nasaViewController = NasaViewController(viewModel: nasaViewModel)
        window?.rootViewController = UINavigationController(rootViewController: nasaViewController)
        window?.makeKeyAndVisible()
    }
}
