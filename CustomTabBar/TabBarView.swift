//
//  TabBarView.swift
//  CustomTabBar
//
//  Created by Ibrahim Nasser Ibrahim on 20/02/2024.
//

import UIKit

class TabBarView: UITabBar {
    
    private var shapeLayer: CAShapeLayer?
    private var circleLayer: CALayer?
    private var previousSelectedItem: UIView?
    var centeredWidth: CGFloat = 0
    
    override func draw(_ rect: CGRect) {
        centeredWidth = self.bounds.width / 2
        self.unselectedItemTintColor = .white
        self.tintColor = .white
        self.addShape()
    }
    
    private func addShape() {
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = getPath(centeredWidth: centeredWidth)
        shapeLayer.fillColor = UIColor.tabBarColor.cgColor
        shapeLayer.shadowOffset = CGSize(width: 0, height: 0)
        shapeLayer.shadowColor = UIColor.black.cgColor
        shapeLayer.shadowOpacity = 0.2
        
        if let oldShape = self.shapeLayer {
            self.layer.replaceSublayer(oldShape, with: shapeLayer)
        } else {
            self.layer.insertSublayer(shapeLayer, at: 0)
        }
        
        self.shapeLayer = shapeLayer
    }
    
    private func getPath(centeredWidth: CGFloat) -> CGPath {
        let height: CGFloat = 57
        let path = UIBezierPath()
        
        path.move(to: CGPoint(x: 0, y: 0))
        
        path.addLine(to: CGPoint(x: centeredWidth - height * 2, y: 0))
        
        path.addCurve(to: CGPoint(x: centeredWidth, y: height),
                      controlPoint1: CGPoint(x: centeredWidth - 30, y: 0),
                      controlPoint2: CGPoint(x: centeredWidth - 35, y: height))
        
        path.addCurve(to: CGPoint(x: centeredWidth + height * 2, y: 0),
                      controlPoint1: CGPoint(x: centeredWidth + 35, y: height),
                      controlPoint2: CGPoint(x: centeredWidth + 30, y: 0))
        
        path.addLine(to: CGPoint(x: self.bounds.width, y: 0))
        path.addLine(to: CGPoint(x: self.bounds.width, y: self.bounds.height))
        path.addLine(to: CGPoint(x: 0, y: self.bounds.height))
        path.addLine(to: CGPoint(x: 0, y: 0))
        
        path.close()
        
        return path.cgPath
    }
    
    func updateTappedItem() {
        guard let selectedTabView = self.selectedItem?.value(forKey: "view") as? UIView else { return }
        
        let newCenteredWidth = selectedTabView.frame.origin.x + (selectedTabView.frame.width / 2)
        
        updateShapeLayer(newCenteredWidth: newCenteredWidth)
        updateCircleLayer(selectedTabView: selectedTabView)
    }
    
    private func updateShapeLayer(newCenteredWidth: CGFloat) {
        animateShapeLayerPath(to: getPath(centeredWidth: newCenteredWidth))
    }
    
    private func animateShapeLayerPath(to newPath: CGPath) {
        let animation = CABasicAnimation(keyPath: "path")
        animation.fromValue = shapeLayer?.path
        animation.toValue = newPath
        animation.duration = 0.3
        shapeLayer?.path = newPath
        shapeLayer?.add(animation, forKey: "pathAnimation")
    }
    
    private func updateCircleLayer(selectedTabView: UIView) {
        removePreviousCircleLayer()
        addCircleLayer(to: selectedTabView)
    }
    
    private func removePreviousCircleLayer() {
        guard let previousSelectedItem = self.previousSelectedItem else { return }
        previousSelectedItem.layer.sublayers?
            .filter { $0.name == "circleLayer" }
            .forEach { $0.removeFromSuperlayer() }
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
