//
//  UIButton+Extension.swift
//  Saiga
//
//  Created by Jean Paul Marinho on 26/08/18.
//  Copyright © 2018 Faganello. All rights reserved.
//

import UIKit

extension UIButton {
    func applyDefaultStyle() {
        self.layer.cornerRadius = 12
        self.backgroundColor = UIColor.hexStringToUIColor(hex: "55A773")
    }
}
