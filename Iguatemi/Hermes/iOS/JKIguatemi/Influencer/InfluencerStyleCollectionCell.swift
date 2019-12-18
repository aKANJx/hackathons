//
//  SearchCollectionCell.swift
//  JKIguatemi
//
//  Created by Jean Paul Marinho on 22/09/18.
//  Copyright © 2018 aKANJ. All rights reserved.
//

import UIKit

class InfluencerStyleCollectionCell: UICollectionViewCell {
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var checkImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        imageView.layer.cornerRadius = 12
    }
}
