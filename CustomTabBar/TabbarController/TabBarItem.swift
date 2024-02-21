//
//  TabBarItem.swift
//  CustomTabBar
//
//  Created by Ibrahim Nasser Ibrahim on 21/02/2024.
//

import UIKit

class TabBarItem: UIView {
    
    private let stackView: UIStackView = UIStackView()
    public let titleLabel = UILabel()
    private let iconView = UIView()
    
    let item: UITabBarItem
    init(item: UITabBarItem) {
        self.item = item
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
