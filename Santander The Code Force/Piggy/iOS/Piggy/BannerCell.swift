//
//  BannerCollectionViewCell.swift
//  Piggy
//
//  Created by Jean Paul Marinho on 11/01/17.
//  Copyright © 2017 aKANJ. All rights reserved.
//

import UIKit

class BannerCell: UICollectionViewCell {

    @IBOutlet var bannerPhoto: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 5
        self.layer.masksToBounds = true
    }

}
