//
//  UIView+Extension.swift
//  Know Notes
//
//  Created by Wylan L Neely on 11/29/20.
//

import UIKit

extension UIView {
    
    func pulsateView() {
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.duration = 0.4
        pulse.fromValue = 0.98
        pulse.toValue = 1.0
        pulse.autoreverses = true
        pulse.repeatCount = .infinity
        pulse.initialVelocity = 0.5
        pulse.damping = 1.0
        layer.add(pulse, forKey: nil)
    }
    
    func pulsateSharps() {
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.duration = 0.5
        pulse.fromValue = 0.75
        pulse.toValue = 1.2
        pulse.autoreverses = true
        pulse.repeatCount = .infinity
        pulse.initialVelocity = 0.5
        pulse.damping = 1.0
        layer.add(pulse, forKey: nil)
    }
    
    func pulseView() {
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.duration = 0.4
        pulse.fromValue = 0.98
        pulse.toValue = 1.0
        pulse.autoreverses = true
        pulse.repeatCount = 3
        pulse.initialVelocity = 0.5
        pulse.damping = 1.0
        layer.add(pulse, forKey: nil)
    }
    func stopPulseView() {
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.duration = 0.4
        pulse.fromValue = 0.98
        pulse.toValue = 1.0
        pulse.autoreverses = true
        pulse.repeatCount = 0
        pulse.initialVelocity = 0.5
        pulse.damping = 1.0
        layer.removeAnimation(forKey: "transform.scale")
    }
    // ->1
     enum Direction: Int {
       case topToBottom = 0
       case bottomToTop
       case leftToRight
       case rightToLeft
     }
     
     func startShimmeringAnimation(animationSpeed: Float = 2.4,
                                   direction: Direction = .leftToRight,
                                   repeatCount: Float = MAXFLOAT) {
       
       // Create color  ->2
       let lightColor = UIColor(displayP3Red: 1.0, green: 1.0, blue: 1.0, alpha: 0.1).cgColor
       let blackColor = UIColor.red.cgColor
       
       // Create a CAGradientLayer  ->3
       let gradientLayer = CAGradientLayer()
       gradientLayer.colors = [blackColor, lightColor, blackColor]
       gradientLayer.frame = CGRect(x: -self.bounds.size.width, y: -self.bounds.size.height, width: 3 * self.bounds.size.width, height: 3 * self.bounds.size.height)
       
       switch direction {
       case .topToBottom:
         gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
         gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
         
       case .bottomToTop:
         gradientLayer.startPoint = CGPoint(x: 0.5, y: 1.0)
         gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.0)
         
       case .leftToRight:
         gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
         gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
         
       case .rightToLeft:
         gradientLayer.startPoint = CGPoint(x: 1.0, y: 0.5)
         gradientLayer.endPoint = CGPoint(x: 0.0, y: 0.5)
       }
       
       gradientLayer.locations =  [0.35, 0.50, 0.65] //[0.4, 0.6]
       self.layer.mask = gradientLayer
       
       // Add animation over gradient Layer  ->4
       CATransaction.begin()
       let animation = CABasicAnimation(keyPath: "locations")
       animation.fromValue = [0.0, 0.1, 0.2]
       animation.toValue = [0.8, 0.9, 1.0]
       animation.duration = CFTimeInterval(animationSpeed)
       animation.repeatCount = repeatCount
       CATransaction.setCompletionBlock { [weak self] in
         guard let strongSelf = self else { return }
         strongSelf.layer.mask = nil
       }
       gradientLayer.add(animation, forKey: "shimmerAnimation")
       CATransaction.commit()
     }
     
     func stopShimmeringAnimation() {
       self.layer.mask = nil
     }
}
