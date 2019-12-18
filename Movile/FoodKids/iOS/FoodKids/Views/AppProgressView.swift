//
//  AppProgressView.swift
//  FoodKids
//
//  Created by Jean Paul Marinho on 19/08/18.
//  Copyright © 2018 Expresso MovHack Expresso MovHack Expresso MovHack Expresso MovHack. All rights reserved.
//

import UIKit

class AppProgressView: UIProgressView {
    
    @IBOutlet var heightConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.transform = self.transform.scaledBy(x: 1, y: 4)
        self.layer.cornerRadius = 8
        self.clipsToBounds = true
        self.layer.sublayers![1].cornerRadius = 8
        self.subviews[1].clipsToBounds = true


    }

}
