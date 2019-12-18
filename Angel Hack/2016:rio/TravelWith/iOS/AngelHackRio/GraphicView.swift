//
//  GraphicView.swift
//  AngelHackRio
//
//  Created by Jean Paul Marinho on 26/06/16.
//  Copyright © 2016 Jean Paul Marinho. All rights reserved.
//

import Foundation
import UIKit

class GraphicView: UIView {
    
    var backgroundImage: UIImage = UIImage(named: "image-topplaceholder")!
    
    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        let shadow = NSShadow()
        shadow.shadowColor = UIColor.black().withAlphaComponent(0.6)
        shadow.shadowOffset =  CGSize(width: 0.1, height: 3.1)
        shadow.shadowBlurRadius = 9
        let rectanglePath = UIBezierPath(roundedRect: CGRect(x:10, y:10, width:self.frame.size.width - 20, height:self.frame.size.height - 20), cornerRadius: 5)
        context!.saveGState()
        context!.setShadow(offset: shadow.shadowOffset, blur: shadow.shadowBlurRadius, color: (shadow.shadowColor as! UIColor).cgColor)
        context!.beginTransparencyLayer(auxiliaryInfo: nil)
        context!.saveGState()
        rectanglePath.addClip()
        context!.scale(x: 1, y: -1)
        context!.draw(in: CGRect(x:10, y:1250, width:backgroundImage.size.width, height:backgroundImage.size.height), byTiling: backgroundImage.cgImage!)
        context!.restoreGState()
        context!.endTransparencyLayer()
        context!.restoreGState()
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = CGRect(x:10, y:10, width:self.frame.size.width - 20, height:self.frame.size.height - 20)
        gradient.colors = [UIColor(white: 0, alpha: 0.7).cgColor, UIColor.clear().cgColor]
        gradient.cornerRadius = 5
        gradient.startPoint = CGPoint(x: 0.5,y: 1)
        gradient.endPoint = CGPoint(x: 0.5, y: 0)
        self.layer.insertSublayer(gradient, at: 0)
    }
}
