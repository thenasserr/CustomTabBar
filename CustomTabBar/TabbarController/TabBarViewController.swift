//
//  TabBarViewController.swift
//  CustomTabBar
//
//  Created by Ahmed Yamany on 21/02/2024.
//

import UIKit
import MakeConstraints

class TabBarViewController: UITabBarController {
    let customTabBar = TabBarView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let vc1 = UIViewController()
        let vc2 = UIViewController()
        let vc3 = UIViewController()
        let vc4 = UIViewController()
        let vc5 = UIViewController()
        vc1.view.backgroundColor = .red
        vc2.view.backgroundColor = .yellow
        vc3.view.backgroundColor = .blue
        vc4.view.backgroundColor = .green
        vc5.view.backgroundColor = .cyan
//        vc1.tabBarItem = TabBarType.home.tabBarItem
//        vc2.tabBarItem = TabBarType.cart.tabBarItem
//        vc3.tabBarItem = TabBarType.notification.tabBarItem
//        vc4.tabBarItem = TabBarType.search.tabBarItem
      
        
        
        
        
        viewControllers = [vc1, vc2, vc3, vc4]
        
        self.tabBar.isHidden = true
        view.addSubview(customTabBar)
        customTabBar.fillXSuperView()
        customTabBar.makeConstraints(bottomAnchor: view.bottomAnchor)
        customTabBar.items = TabBarType.allCases.map {$0.tabBarItem}
        
        customTabBar.delegate = self
        customTabBar.selectedItem = customTabBar.items?.first
       
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        selectedIndex = item.tag
        print("dsfsdf")
    }
    
}

