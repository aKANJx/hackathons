//
//  BorderView.swift
//  JKIguatemi
//
//  Created by Jean Paul Marinho on 22/09/18.
//  Copyright © 2018 aKANJ. All rights reserved.
//

import UIKit

class InstagramBorderView: UIView {

    override func awakeFromNib() {
        super.awakeFromNib()
        layer.borderWidth = 1
        layer.borderColor = UIColor.lightGray.cgColor
        
    }

}
