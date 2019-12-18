//
//  GradientBackgroundView.swift
//  Piggy
//
//  Created by Jean Paul Marinho on 12/01/17.
//  Copyright © 2017 aKANJ. All rights reserved.
//

import UIKit

@IBDesignable
class GradientBackgroundView: UIView {

    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()!
        let colorTop =  UIColor(hexString: "f0435f")?.cgColor
        let colorBottom = UIColor(hexString: "d51131")?.cgColor
        let gradient = CGGradient(colorsSpace: nil, colors: [colorTop, colorBottom] as CFArray, locations: [0, 1])!
        let rectanglePath = UIBezierPath(rect: self.bounds)
        context.saveGState()
        rectanglePath.addClip()
        context.drawLinearGradient(gradient, start: CGPoint(x: 0, y: 0), end: CGPoint(x: self.bounds.width, y: self.bounds.height), options: [])
        context.restoreGState()
    }
}
