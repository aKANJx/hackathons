//
//  RoundedImageView.swift
//  ZipRecruiter
//
//  Created by Jean Paul Marinho on 07/05/17.
//  Copyright © 2017 aKANJ. All rights reserved.
//

import UIKit

class RoundedImageView: UIImageView {

    override func awakeFromNib() {
        self.layer.cornerRadius = self.frame.width/2.0
    }
}
