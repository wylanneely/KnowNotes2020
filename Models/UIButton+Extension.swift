//
//  UIButton+Extension.swift
//  Know Notes
//
//  Created by Wylan L Neely on 11/29/20.
//

import UIKit

extension UIButton {
    func pulsate() {
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
    func pulse() {
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
    func stopPulse() {
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
    func flash() {
        let flash = CABasicAnimation(keyPath: "opacity")
        flash.duration = 0.3
        flash.fromValue = 1
        flash.toValue = 0.1
        flash.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        flash.autoreverses = true
        flash.repeatCount = 2
        layer.add(flash, forKey: nil)
    }
}
