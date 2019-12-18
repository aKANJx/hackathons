//
//  AppButton.swift
//  Piggy
//
//  Created by Jean Paul Marinho on 12/01/17.
//  Copyright © 2017 aKANJ. All rights reserved.
//

import UIKit

class AppButton: UIButton {
    
    @IBInspectable
    var cornerRadius: Int = 0
    @IBInspectable
    var isFillable: Bool = true
    @IBInspectable
    var borderWidth: Float = 0
    
    override func awakeFromNib() {
        self.layer.cornerRadius = CGFloat(self.cornerRadius)
        self.layer.masksToBounds = true
        if !self.isFillable {
            self.layer.borderColor = UIColor.white.cgColor
            self.layer.borderWidth = CGFloat(self.borderWidth)
        }
    }
}
