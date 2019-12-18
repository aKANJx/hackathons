//
//  TagView.swift
//  AngelHackRio
//
//  Created by Jean Paul Marinho on 26/06/16.
//  Copyright © 2016 Jean Paul Marinho. All rights reserved.
//

import UIKit

@IBDesignable
class TagView: UIView {
    
    override func draw(_ rect: CGRect) {
        let frameSize = self.frame.size
        let rectanglePath = UIBezierPath(roundedRect: CGRect(x:0, y:0, width: frameSize.width, height: frameSize.height), cornerRadius: 8)
        UIColor(colorLiteralRed: 24/255.0, green: 154/255.0, blue: 202/255.0, alpha: 1.0).setFill()
        rectanglePath.fill()
    }
}
