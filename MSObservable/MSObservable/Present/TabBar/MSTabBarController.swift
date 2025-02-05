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
        
        let wordCounterViewController = WordCounterViewController()
        wordCounterViewController.tabBarItem = UITabBarItem(
            title: "글자계산기",
            image: UIImage(systemName: "text.document"),
            selectedImage: UIImage(systemName: "text.document")
        )
        
        let userListViewController = UserListViewController()
        userListViewController.tabBarItem = UITabBarItem(
            title: "유저리스트",
            image: UIImage(systemName: "person.circle"),
            selectedImage: UIImage(systemName: "person.circle")
        )
        
        let currencyExchangeNavigationController = UINavigationController(rootViewController: currencyExchangeViewController)
        let wordCounterNavigationController = UINavigationController(rootViewController: wordCounterViewController)
        let userListNavigationController = UINavigationController(rootViewController: userListViewController)
        setViewControllers(
            [currencyExchangeNavigationController, wordCounterNavigationController, userListNavigationController],
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
