//
//  CarCategoryCollectionViewCell.swift
//  Torq
//
//  Created by Felipe Antonio Cardoso on 20/10/2018.
//  Copyright © 2018 aKANJ. All rights reserved.
//

import UIKit

class CarCategoryCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imgcategory: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = 10
        clipsToBounds = true
    }
}
