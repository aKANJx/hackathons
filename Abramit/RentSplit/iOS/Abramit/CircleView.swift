//
//  CircleView.swift
//  Abramit
//
//  Created by Jean Paul Marinho on 15/11/17.
//  Copyright © 2017 aKANJ. All rights reserved.
//

import UIKit

class CircleView: UIImageView {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.layer.cornerRadius = self.frame.width / 2.0
        self.layer.masksToBounds = true
    }
    
}
