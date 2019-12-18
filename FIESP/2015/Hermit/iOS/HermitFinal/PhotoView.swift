//
//  PhotoView.swift
//  HermitFinal
//
//  Created by Jean Paul dos Santos Marinho on 22/08/15.
//  Copyright (c) 2015 Jean Paul Marinho. All rights reserved.
//

import UIKit

//@IBDesignable
class PhotoView: UIView {
    
    //@IBInspectable
    var image: UIImage?
    var placeholderPhoto: UIImage
    //@IBInspectable
    var lineWidth: CGFloat = 5
    var circleColor: UIColor = UIColor(red: 38/255.0, green: 99/255.0, blue: 159/255.0, alpha: 1.0)
    
    required init(coder aDecoder: NSCoder) {
        placeholderPhoto = UIImage(named: "photoPlaceholder")!
        super.init(coder: aDecoder)
        self.backgroundColor = UIColor.clearColor()
    }
    
    override func drawRect(rect: CGRect) {
        //// General Declarations
        let context = UIGraphicsGetCurrentContext()
        let rect = CGRectMake(lineWidth/2.0, lineWidth/2.0, bounds.width - lineWidth, bounds.height - lineWidth)
        //// ProfessionalImageView Drawing
        var path = UIBezierPath(ovalInRect: rect)
        CGContextSaveGState(context)
        path.addClip()
        if image == nil {
            placeholderPhoto.drawInRect(rect)
        }
        else {
            image!.drawInRect(rect)
        }
        CGContextRestoreGState(context)
        circleColor.setStroke()
        path.lineWidth = lineWidth
        path.stroke()
    }
}