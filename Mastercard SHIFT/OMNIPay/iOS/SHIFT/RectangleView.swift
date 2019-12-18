//
//  RectangleView.swift
//  SHIFT
//
//  Created by Jean Paul Marinho on 11/06/16.
//  Copyright © 2016 Jean Paul Marinho. All rights reserved.
//

import UIKit

@IBDesignable class RectangleView: UIButton {

    @IBInspectable var color: UIColor = UIColor(red: 0.800, green: 0.027, blue: 0.118, alpha: 1.000)
    @IBInspectable var lineWidth: CGFloat = 2
    @IBInspectable var cornerRadius: CGFloat = 2
    @IBInspectable var isFilled: Bool = true
    @IBInspectable var isCapsule: Bool = true
    
    override func drawRect(rect: CGRect) {
        let frameSize = self.frame.size
        var rectanglePath: UIBezierPath
        if isCapsule {
            self.cornerRadius = frameSize.height/2.0
        }
        if isFilled {
            rectanglePath = UIBezierPath(roundedRect: CGRectMake(
                0,
                0,
                frameSize.width,
                frameSize.height), cornerRadius: self.cornerRadius)
            self.color.setFill()
            rectanglePath.fill()
        }
        else {
            rectanglePath = UIBezierPath(roundedRect: CGRectMake(
                self.lineWidth/2.0,
                self.lineWidth/2.0,
                frameSize.width - self.lineWidth,
                frameSize.height - self.lineWidth), cornerRadius: frameSize.height/2.0)
            color.setStroke()
            rectanglePath.lineWidth = self.lineWidth
            rectanglePath.stroke()
            
        }
    }
}
