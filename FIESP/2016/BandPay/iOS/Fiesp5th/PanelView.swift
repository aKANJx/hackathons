//
//  PanelView.swift
//  Fiesp5th
//
//  Created by Jean Paul Marinho on 15/10/16.
//  Copyright © 2016 aKANJ. All rights reserved.
//

import UIKit
import CoreLocation

@IBDesignable
class PanelView: UIView {

    var hasShadow = false
    @IBInspectable var color: UIColor = UIColor.baseSet
    
    override func draw(_ rect: CGRect) {
        
        let context = UIGraphicsGetCurrentContext()
        let rectanglePath = UIBezierPath(roundedRect: CGRect(x: 1, y: 1, width: self.frame.width - 2, height: self.frame.height - 2), cornerRadius: 5)
        if hasShadow {
            let shadow = NSShadow()
            shadow.shadowColor = UIColor.black.withAlphaComponent(0.44)
            shadow.shadowOffset = CGSize(width: 0.1, height: -0.1)
            shadow.shadowBlurRadius = 1
            context!.setShadow(offset: shadow.shadowOffset, blur: shadow.shadowBlurRadius, color: (shadow.shadowColor as! UIColor).cgColor)
        }
        context!.saveGState()
        self.color.setFill()
        rectanglePath.fill()
        context!.restoreGState()
    }
}
