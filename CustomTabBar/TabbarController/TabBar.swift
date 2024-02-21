//
//  TabBar.swift
//  CustomTabBar
//
//  Created by Ibrahim Nasser Ibrahim on 21/02/2024.
//

import UIKit
import MakeConstraints

class TabBar: UIView {
    private let stackView: UIStackView = UIStackView()
    
    // MARK: - Initializer
    //
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    // MARK: - setup subviews
    //
    private func setup() {
        backgroundColor = .white
//        heightConstraints(46 + (UIApplication.shared.mainWindow?.safeAreaInsets.bottom ?? 20))
        layer.cornerRadius = 12
        setupStackView()
    }
    
    private func setupStackView() {
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        addSubview(stackView)
        
//        let bottomPadding = (UIApplication.shared.mainWindow?.safeAreaInsets.bottom ?? 0) / 2
//        let padding = UIEdgeInsets(top: 0, left: 32, bottom: bottomPadding, right: 32)
//        stackView.fillSuperview(padding: padding)
    }
}
