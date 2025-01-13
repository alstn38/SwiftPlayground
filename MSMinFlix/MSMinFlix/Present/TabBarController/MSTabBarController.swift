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
        
        // addSubView 시도해보기
//        let view = UIView()
//        view.backgroundColor = .green
//        view.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
//        view.addSubview(view)
        
        // 이유 생각 -
        // 컨테이너는 말 그대로 담는 것임.
        // 공식문서에서도 탭 바 컨트롤러의 뷰는 탭 바 뷰의 컨테이너일 뿐이라고 나와있음.
        // 결론: 단순히 view는 컨테이너의 역할을 하기 때문에 addSubView를 하는 것은 불가능할 것이다.
        
        // 직접 Container VC를 만들때 addSubView를 한다면, 부모 - 자식 관계 형성 후, 자식의 view만 넣을 수 있는것으로 보인다.
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
