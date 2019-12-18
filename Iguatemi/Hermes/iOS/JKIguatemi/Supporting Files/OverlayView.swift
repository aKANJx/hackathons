//
//  OverlayView.swift
//  JKIguatemi
//
//  Created by Jean Paul Marinho on 22/09/18.
//  Copyright © 2018 aKANJ. All rights reserved.
//

import UIKit

class OverlayView: UIView {
    
    @IBInspectable var offset: CGSize = .zero
    
    override func awakeFromNib() {
        self.layer.cornerRadius = 12
        self.layer.addShadow(with: offset)
    }
}


class BorderView: UIView {
    
    @IBInspectable var borderColor: UIColor = .groupTableViewBackground {
        didSet {
            configure()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configure()
    }
    
    private func configure() {
        layer.roundCorners(radius: 12)
        layer.borderWidth = 1.5
        layer.borderColor = borderColor.cgColor
    }
}
