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
}
