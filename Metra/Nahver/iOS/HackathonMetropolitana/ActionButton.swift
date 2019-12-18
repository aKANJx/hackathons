//
//  ActionButton.swift
//  HackathonMetropolitana
//
//  Created by Jean Paul Marinho on 19/03/17.
//  Copyright © 2017 aKANJ. All rights reserved.
//

import UIKit

@IBDesignable
class ActionButton: UIButton {

    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()!
        let color = UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 1.000)
        let shadow = NSShadow()
        shadow.shadowColor = UIColor.black.withAlphaComponent(0.2)
        shadow.shadowOffset = CGSize(width: 0, height: 0)
        shadow.shadowBlurRadius = 5
        let ovalPath = UIBezierPath(ovalIn: CGRect(x: 5, y: 5, width: self.frame.width - 10, height: self.frame.height - 10))
        context.saveGState()
        context.setShadow(offset: shadow.shadowOffset, blur: shadow.shadowBlurRadius, color: (shadow.shadowColor as! UIColor).cgColor)
        color.setFill()
        ovalPath.fill()
        context.restoreGState()
        UIColor.black.setStroke()
        ovalPath.lineWidth = 0.1
        ovalPath.stroke()
    }
}
