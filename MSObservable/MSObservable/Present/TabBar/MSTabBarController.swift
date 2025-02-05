//
//  MSTabBarController.swift
//  MSObservable
//
//  Created by 강민수 on 2/5/25.
//

import UIKit

final class MSTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupTabBarController()
        setupTabBarAppearance()
    }
    
    private func setupTabBarController() {
        let currencyExchangeViewController = CurrencyExchangeViewController()
        currencyExchangeViewController.tabBarItem = UITabBarItem(
            title: "환전",
            image: UIImage(systemName: "wonsign.bank.building"),
            selectedImage: UIImage(systemName: "wonsign.bank.building")
        )
        
        let currencyExchangeNavigationController = UINavigationController(rootViewController: currencyExchangeViewController)
        setViewControllers(
            [currencyExchangeNavigationController],
            animated: true
        )
    }
    
    private func setupTabBarAppearance() {
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithOpaqueBackground()
        tabBarAppearance.backgroundColor = .white
        tabBarAppearance.stackedLayoutAppearance.normal.iconColor = .gray
        tabBarAppearance.stackedLayoutAppearance.selected.iconColor = .black
        tabBar.standardAppearance = tabBarAppearance
        tabBar.scrollEdgeAppearance = tabBarAppearance
        tabBar.tintColor = .black
    }
}
