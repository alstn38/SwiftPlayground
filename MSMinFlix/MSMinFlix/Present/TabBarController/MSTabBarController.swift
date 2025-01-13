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
        tabBar.tintColor = .black
        tabBar.backgroundColor = .white
    }
    
    private func setupViewControllers() {
        let minFlixViewController = MinFlixViewController()
        minFlixViewController.tabBarItem = UITabBarItem(
            title: "MinFlix",
            image: UIImage(systemName: "house"),
            selectedImage: UIImage(systemName: "house.fill")
        )
        
        viewControllers = [minFlixViewController]
    }
}
