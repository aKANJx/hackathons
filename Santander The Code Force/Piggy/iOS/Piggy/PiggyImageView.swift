//
//  PiggyView.swift
//  Piggy
//
//  Created by Jean Paul Marinho on 17/01/17.
//  Copyright © 2017 aKANJ. All rights reserved.
//

import UIKit

class PiggyImageView: UIImageView {
    
    func image(image: UIImage, withType type: PiggyType) {
        self.image = image
        self.layer.masksToBounds = true
        switch type {
        case .personal:
            self.layer.cornerRadius = self.frame.width / 2.0
        case .event:
            self.layer.cornerRadius = 5
        }
        self.setNeedsDisplay()
    }
    
}
