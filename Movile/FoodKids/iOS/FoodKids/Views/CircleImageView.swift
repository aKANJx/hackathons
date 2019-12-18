//
//  CircleView.swift
//  FoodKids
//
//  Created by Jean Paul Marinho on 19/08/18.
//  Copyright © 2018 Expresso MovHack Expresso MovHack Expresso MovHack Expresso MovHack. All rights reserved.
//

import UIKit

class CircleImageView: UIImageView {
    
    override func awakeFromNib() {
        self.layer.cornerRadius = self.frame.height / 2.0
        self.clipsToBounds = true
    }

}
