//
//  CellBackground.swift
//  HermitFinal
//
//  Created by Jean Paul dos Santos Marinho on 22/08/15.
//  Copyright (c) 2015 Jean Paul Marinho. All rights reserved.
//

import UIKit

class CellBackground: UIView {
    
    var color: UIColor = UIColor(red: 240/255.0, green: 240/255.0, blue: 240/255.0, alpha: 1.0)
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.backgroundColor = UIColor.clearColor()
    }
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
        //// Rectangle Drawing
        let rectanglePath =
        UIBezierPath(roundedRect: CGRectMake(0, 0, self.bounds.width, self.bounds.height), cornerRadius: 15)
        color.setFill()
        rectanglePath.fill()
    }
    
}