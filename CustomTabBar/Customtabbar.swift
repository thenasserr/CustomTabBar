//
//  Customtabbar.swift
//  CustomTabBar
//
//  Created by Ibrahim Nasser Ibrahim on 20/02/2024.
//

import UIKit

class Customtabbar: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.delegate = self
        self.selectedIndex = 2
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if let tabbar = tabBar as? TabBarView {
            tabbar.updateTappedItem()
        }
    }
}
