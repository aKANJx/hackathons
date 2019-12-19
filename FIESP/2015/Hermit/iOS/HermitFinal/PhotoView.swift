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
    
    required init?(coder aDecoder: NSCoder) {
        placeholderPhoto = UIImage(named: "photoPlaceholder")!
        super.init(coder: aDecoder)
        self.backgroundColor = UIColor.clear
    }
    
    override func draw(_ rect: CGRect) {
        //// General Declarations
        let context = UIGraphicsGetCurrentContext()
        let rect = CGRect(x: lineWidth/2.0, y: lineWidth/2.0, width: bounds.width - lineWidth, height: bounds.height - lineWidth)
        //// ProfessionalImageView Drawing
        var path = UIBezierPath(ovalIn: rect)
        context!.saveGState()
        path.addClip()
        if image == nil {
            placeholderPhoto.draw(in: rect)
        }
        else {
            image!.draw(in: rect)
        }
        context!.restoreGState()
        circleColor.setStroke()
        path.lineWidth = lineWidth
        path.stroke()
    }
}
