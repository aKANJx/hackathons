//
//  AppButton.swift
//  FoodKids
//
//  Created by Jean Paul Marinho on 19/08/18.
//  Copyright © 2018 Expresso MovHack Expresso MovHack Expresso MovHack Expresso MovHack. All rights reserved.
//

import UIKit

class AppButton: UIButton {

    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor.white
        self.setTitleColor(UIColor.darkGray, for: .normal)
        self.layer.cornerRadius = 4
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 1, height: 1)
        self.layer.shadowRadius = 1
        self.layer.shadowOpacity = 0.5

    }

}
