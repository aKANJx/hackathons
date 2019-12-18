//
//  HolderView.swift
//  SBLoader
//
//  Created by Satraj Bambra on 2015-03-17.
//  Copyright (c) 2015 Satraj Bambra. All rights reserved.
//

import UIKit
import Foundation

class WaterView: UIView {

  let arcLayer = ArcLayer()
  var parentFrame :CGRect = CGRect.zero
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    backgroundColor = UIColor.clear
  }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

  func drawArc() {
    layer.addSublayer(arcLayer)
    arcLayer.animate()
    Timer.scheduledTimer(timeInterval: 0.90, target: self, selector: #selector(WaterView.expandView),
      userInfo: nil, repeats: false)
  }

  func expandView() {
    backgroundColor = UIColor(red: 46.0 / 255.0, green: 117.0 / 255.0, blue: 146.0 / 255.0, alpha: 1.0)
    frame = CGRect(x: 0,
                   y: 0,
                   width: frame.size.width,
                   height: frame.size.height)
    layer.sublayers = nil

    UIView.animate(withDuration: 0.3, delay: 0.0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
      self.frame = self.parentFrame
      }, completion: { finished in
    })
  }
}
