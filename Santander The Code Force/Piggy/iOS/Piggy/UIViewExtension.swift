//
//  UIViewExtension.swift
//  Piggy
//
//  Created by Jean Paul Marinho on 17/01/17.
//  Copyright © 2017 aKANJ. All rights reserved.
//

import UIKit

extension UIView {
    
    func roundCorners(corners:UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
}

extension UIGestureRecognizer {
    func cancel() {
        isEnabled = false
        isEnabled = true
    }
}
