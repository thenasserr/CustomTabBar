//
//  TabBarView.swift
//  CustomTabBar
//
//  Created by Ibrahim Nasser Ibrahim on 20/02/2024.
//

import UIKit

class TabBarView: UITabBar {
    // MARK: - Properties
    private let viewHeight: CGFloat = 80
    private let shapeHeight: CGFloat = 38
    private var shapeCenterPoint: CGFloat = 0
    
    // MARK: - SubViews
    private var shapeLayer: CAShapeLayer = CAShapeLayer()
    
    private var circleLayer: CALayer?
    private var previousSelectedItem: UIView?
    
    
    override var selectedItem: UITabBarItem? {
        didSet {
            layoutIfNeeded()
            updateSelectedItem(selectedItem: selectedItem)
        }
    }
    
    override func draw(_ rect: CGRect) {
        setup()
    }
    
    func setup() {
        setupConstraints()
        updateUI()
        updateShapeLayer()
        addShapeLayer()
    }
    
    private func setupConstraints() {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: viewHeight).isActive = true
    }
    
    private func updateUI() {
        self.unselectedItemTintColor = .white
        self.tintColor = .white
    }
    
    private func addShapeLayer() {
        self.layer.insertSublayer(shapeLayer, at: 0)
    }
    
    private func updateShapeLayer() {
        shapeLayer.fillColor = UIColor.tabBarColor.cgColor
        shapeLayer.shadowOffset = CGSize(width: 0, height: 0)
        shapeLayer.shadowColor = UIColor.black.cgColor
        shapeLayer.shadowOpacity = 0.2
    }
    
    private func createShapePath(centeredTo centerPoint: CGFloat, withHeight height: CGFloat) -> CGPath {
        let path = UIBezierPath()
        
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: centerPoint - height * 2, y: 0))
        
        path.addCurve(to: CGPoint(x: centerPoint, y: height),
                      controlPoint1: CGPoint(x: centerPoint - 30, y: 0),
                      controlPoint2: CGPoint(x: centerPoint - 35, y: height))
        
        path.addCurve(to: CGPoint(x: centerPoint + height * 2, y: 0),
                      controlPoint1: CGPoint(x: centerPoint + 35, y: height),
                      controlPoint2: CGPoint(x: centerPoint + 30, y: 0))
        
        path.addLine(to: CGPoint(x: self.bounds.width, y: 0))
        path.addLine(to: CGPoint(x: self.bounds.width, y: viewHeight))
        path.addLine(to: CGPoint(x: 0, y: viewHeight))
        path.addLine(to: CGPoint(x: 0, y: 0))
        
        path.close()
        
        return path.cgPath
    }
    
    private func updateSelectedItem(selectedItem: UITabBarItem?) {
        guard let selectedItemView = selectedItem?.value(forKey: "view") as? UIView else {
            print("updateTappedItem returned")
            return
        }
        
        let selectedItemCenterPoint = getCenterPoint(of: selectedItemView)
        moveShapeCurve(to: selectedItemCenterPoint, withHeight: shapeHeight)
        update(selectedItemView)
        updateCircleLayer(selectedTabView: selectedItemView)
    }
    
    private func getCenterPoint(of selectedItemView: UIView) -> CGFloat {
        return selectedItemView.frame.origin.x + (selectedItemView.frame.width / 2)
    }
    
    // MARK: - Updata Curve
    private func moveShapeCurve(to point: CGFloat, withHeight height: CGFloat) {
        let newPath = createShapePath(centeredTo: point, withHeight: height)
        animateCurve(from: shapeLayer.path, to: newPath)
        shapeLayer.path = newPath
    }
    
    private func animateCurve(from path: CGPath?, to newPath: CGPath) {
        let animation = createCurveAnimation(from: path, to: newPath)
        shapeLayer.add(animation, forKey: "curveAnimation")
    }
    
    private func createCurveAnimation(from path: CGPath?, to newPath: CGPath) -> CABasicAnimation {
        let animation = CABasicAnimation(keyPath: "path")
        animation.fromValue = path
        animation.toValue = newPath
        animation.duration = 0.3
        return animation
    }
    
    
    // MARK: - Update Selected View
    private func update(_ view: UIView) {
        
    }
    
    
    private func updateCircleLayer(selectedTabView: UIView) {
        selectedTabView.layoutIfNeeded()
        addCircleLayer(to: selectedTabView)
    }
    
    private func removePreviousCircleLayer() {
        guard let previousSelectedItem = self.previousSelectedItem else {
            print("nilldsfa")
            return
        }
        previousSelectedItem.layer.sublayers?
            .filter { $0.name == "circleLayer" }
            .forEach { $0.removeFromSuperlayer() }
        
        let x = previousSelectedItem.frame.origin.x
        let y = previousSelectedItem.frame.origin.y + 20
        let width = previousSelectedItem.frame.width
        let heightv = previousSelectedItem.frame.height
        previousSelectedItem.frame = CGRect(x: x, y: y, width: width, height: heightv)
    }
    
     func addCircleLayer(to selectedTabView: UIView) {
        let height: CGFloat = 55
        let circleLayer = CALayer()
        circleLayer.bounds = CGRect(x: 0, y: 0, width: height, height: height)
        circleLayer.position = CGPoint(x: selectedTabView.bounds.width / 2, y: selectedTabView.bounds.height / 2)
        circleLayer.cornerRadius = height / 2
        circleLayer.backgroundColor = UIColor.selectedTabColor.cgColor
        circleLayer.name = "circleLayer"
        
        animateCircleLayerPosition(for: circleLayer, on: selectedTabView)
        selectedTabView.layer.addSublayer(circleLayer)
         let x = selectedTabView.frame.origin.x
         let y = selectedTabView.frame.origin.y - 20
         let width = selectedTabView.frame.width
         let heightv = selectedTabView.frame.height
         selectedTabView.frame = CGRect(x: x, y: y, width: width, height: heightv)
         removePreviousCircleLayer()
        self.previousSelectedItem = selectedTabView
    }
    
    private func animateCircleLayerPosition(for circleLayer: CALayer, on selectedTabView: UIView) {
        let animation = CABasicAnimation(keyPath: "position")
        animation.fromValue = previousSelectedItem?.layer.sublayers?.first?.position ?? circleLayer.position
        animation.toValue = circleLayer.position
        animation.duration = 0.3
        circleLayer.add(animation, forKey: "positionAnimation")
    }
}

extension UIColor {
    static var tabBarColor: UIColor {
        return UIColor(named: "tabbar") ?? .clear
    }
    
    static var selectedTabColor: UIColor {
        return UIColor(named: "selected") ?? .clear
    }
}
