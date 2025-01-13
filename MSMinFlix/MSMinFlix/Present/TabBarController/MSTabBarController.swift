//
//  ViewController.swift
//  MSMinFlix
//
//  Created by 강민수 on 1/13/25.
//

import UIKit

final class MSTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabBar()
        setupViewControllers()
    }
    
    private func setupTabBar() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        tabBar.standardAppearance = appearance
        tabBar.tintColor = .white
    }
    
    private func setupViewControllers() {
        let minFlixViewController = MinFlixViewController()
        minFlixViewController.tabBarItem = UITabBarItem(
            title: "MINFLIX",
            image: UIImage(systemName: "house"),
            selectedImage: UIImage(systemName: "house.fill")
        )
        
        let payViewController = PayViewController()
        payViewController.tabBarItem = UITabBarItem(
            title: "Pay",
            image: UIImage(systemName: "bitcoinsign.circle"),
            selectedImage: UIImage(systemName: "bitcoinsign.circle.fill")
        )
        
        let searchViewController = SearchViewController()
        searchViewController.tabBarItem = UITabBarItem(
            title: "Search",
            image: UIImage(systemName: "magnifyingglass"),
            selectedImage: UIImage(systemName: "magnifyingglass")
        )
        
        viewControllers = [minFlixViewController, payViewController, searchViewController]
    }
}
