//
//  CardView.swift
//  DubaiHackBO
//
//  Created by Jean Paul Marinho on 21/04/18.
//  Copyright © 2018 aKANJ. All rights reserved.
//

import UIKit

class CardView: UIView {

    override func awakeFromNib() {
        self.layer.cornerRadius = 20
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOpacity = 0.6
        self.layer.shadowOffset = CGSize.zero
        self.layer.shadowRadius = 14
    }

}
