//
//  ViewLoad.swift
//  FoodKids
//
//  Created by Marcos Vinicius Souza Lacerda on 19/08/2018.
//  Copyright © 2018 Expresso MovHack Expresso MovHack Expresso MovHack Expresso MovHack. All rights reserved.
//

import UIKit
import KRActivityIndicatorView

class ViewLoad: UIView {

    @IBOutlet weak var gradientView : GradientView!
    @IBOutlet weak var lbTitle      : UILabel!
    
    func startAnimation(){
        
        let activityIndicator = KRActivityIndicatorView(frame: CGRect(x: 87, y: 265, width: 320, height: 220))
        
        activityIndicator.style = .gradationColor(head: UIColor(red:0.70, green:0.86, blue:0.87, alpha:1.0), tail: UIColor(red:0.70, green:0.86, blue:0.87, alpha:1.0))
        
        activityIndicator.center = center
        
        activityIndicator.isLarge = true
        
        addSubview(activityIndicator)
        
        activityIndicator.startAnimating()
    }
}
