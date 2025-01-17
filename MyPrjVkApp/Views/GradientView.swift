//
//  GradientView.swift
//  MyPrjVkApp
//
//  Created by Ахмад Амирович on 11.08.2024.
//

import UIKit

class GradientView: UIView {
    
    
    @IBInspectable var startColor: UIColor = .white {
        didSet {
            self.updateColors()
        }
    }
    
    @IBInspectable var endColor: UIColor = .black {
        didSet {
            self.updateColors()
        }
    }
    
    @IBInspectable var startLocation: CGFloat = 0.0 {
        didSet {
            self.updateLocation()
        }
    }
    
    @IBInspectable var endLocation: CGFloat = 1.0 {
        didSet {
            self.updateLocation()
        }
    }
    
    @IBInspectable var startPoint: CGPoint = .zero {
        didSet {
            self.updateStartPoint()
        }
    }
    
    @IBInspectable var endPoint: CGPoint = CGPoint(x: 0.0, y: 1.0) {
        didSet {
            self.updateEndPoint()
        }
    }
    
    override static var layerClass: AnyClass {
        return CAGradientLayer.self
    }
    
    var gradientLayer: CAGradientLayer {
        return self.layer as! CAGradientLayer
    }
    
    func updateLocation() {
        self.gradientLayer.locations = [
            self.startLocation as NSNumber,
            self.endLocation as NSNumber
        ]
    }
    
    func updateColors() {
        self.gradientLayer.colors = [
            self.startColor.cgColor,
            self.endColor.cgColor
        ]
    }
    
    func updateStartPoint() {
        self.gradientLayer.startPoint = self.startPoint
    }
    
    func updateEndPoint() {
        self.gradientLayer.endPoint = self.endPoint
    }
    

}
