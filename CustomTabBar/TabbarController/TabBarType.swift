//
//  TabBarType.swift
//  CustomTabBar
//
//  Created by Ibrahim Nasser Ibrahim on 21/02/2024.
//

import UIKit

enum TabBarType: Int, CaseIterable, Hashable {
    case home = 0
    case search
    case notification
    case cart
    case settings
    
    private var title: String {
        switch self {
            case .home: "Home"
            case .search: "Search"
            case .notification: "Notifi"
            case .cart: "Cart"
            case .settings: "Settings"
        }
    }
    
    private var icon: UIImage? {
        switch self {
            case .home: UIImage(systemName: "house")
            case .search: UIImage(systemName: "magnifyingglass.circle")
            case .notification: UIImage(systemName: "bell")
            case .cart: UIImage(systemName: "cart")
            case .settings: UIImage(systemName: "gear.circle")
        }
    }
    
    private var selectedIcon: UIImage? {
        switch self {
            case .home: UIImage(systemName: "house.fill")
            case .search: UIImage(systemName: "magnifyingglass.circle.fill")
            case .notification: UIImage(systemName: "bell.fill")
            case .cart: UIImage(systemName: "cart.fill")
            case .settings: UIImage(systemName: "gear.circle.fill")
        }
    }
    
    var tabBarItem: UITabBarItem {
        let item = UITabBarItem(title: title, image: icon, selectedImage: selectedIcon)
        item.tag = self.rawValue
        return item
    }
}
