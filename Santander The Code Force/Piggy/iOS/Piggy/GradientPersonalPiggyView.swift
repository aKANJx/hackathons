//
//  GradientPersonalPiggyView.swift
//  Piggy
//
//  Created by Jean Paul Marinho on 13/01/17.
//  Copyright © 2017 aKANJ. All rights reserved.
//

import UIKit

@IBDesignable
class GradientPersonalPiggyView: UIView {

    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()!
        let color1 =  UIColor(hexString: "ffffff")?.cgColor
        let color2 = UIColor(hexString: "ffffff")?.cgColor
        let color3 = UIColor(hexString: "fffbfc")?.cgColor
        let color4 = UIColor(hexString: "fff6f9")?.cgColor
        let color5 = UIColor(hexString: "fff2f4")?.cgColor
        let color6 = UIColor(hexString: "ffecf0")?.cgColor
        let gradient = CGGradient(colorsSpace: nil, colors: [color1, color2, color3, color4, color5, color6] as CFArray, locations: [0, 0.2, 0.4, 0.6, 0.8, 1])!
        let rectanglePath = UIBezierPath(rect: self.bounds)
        context.saveGState()
        rectanglePath.addClip()
        context.drawLinearGradient(gradient, start: CGPoint(x: 0, y: 0), end: CGPoint(x: 0, y: self.bounds.height), options: [])
        context.restoreGState()
    }

}
