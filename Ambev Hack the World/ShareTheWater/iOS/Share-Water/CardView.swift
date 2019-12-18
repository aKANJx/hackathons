//
//  CardView.swift
//  Share-Water
//
//  Created by Jean Paul Marinho on 15/02/17.
//  Copyright © 2017 aKANJ. All rights reserved.
//

import UIKit

@IBDesignable
class CardView: UIView {

    override func draw(_ rect: CGRect) {
        
        let context = UIGraphicsGetCurrentContext()!
        let color = UIColor.white
        let shadow = NSShadow()
        shadow.shadowColor = UIColor.black.withAlphaComponent(0.2)
        shadow.shadowOffset = CGSize(width: 0, height: 0)
        shadow.shadowBlurRadius = 5
        let frameSize = self.bounds.size
        let rectanglePath = UIBezierPath(rect: CGRect(x: 5, y: 5, width: frameSize.width-10, height: frameSize.height-10))
        context.saveGState()
        context.setShadow(offset: shadow.shadowOffset, blur: shadow.shadowBlurRadius, color: (shadow.shadowColor as! UIColor).cgColor)
        color.setFill()
        rectanglePath.fill()
        context.restoreGState()
    }
}
