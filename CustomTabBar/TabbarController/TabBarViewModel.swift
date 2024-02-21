//
//  TabBarViewModel.swift
//  CustomTabBar
//
//  Created by Ibrahim Nasser Ibrahim on 21/02/2024.
//

import UIKit
import Combine

protocol EMTabBarViewModelInterface: AnyObject {
    var tabBarIsHidden: Bool { get set }
    var tabBarIsHiddenPublisher: Published<Bool>.Publisher { get }
    
    var selectedTab: TabBarType { get set }
    var selectedTabPublisher: Published<TabBarType>.Publisher { get }
    
    var viewControllers: [UIViewController] { get set }
}

class EMTabBarViewModel: ObservableObject, EMTabBarViewModelInterface {
    static let shared = EMTabBarViewModel()
    
    @Published var tabBarIsHidden: Bool = false
    var tabBarIsHiddenPublisher: Published<Bool>.Publisher { $tabBarIsHidden }
    
    @Published var selectedTab: TabBarType = .home
    var selectedTabPublisher: Published<TabBarType>.Publisher { $selectedTab }
    
    var viewControllers: [UIViewController] = []
}
