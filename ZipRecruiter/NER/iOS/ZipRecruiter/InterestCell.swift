//
//  InterestCell.swift
//  ZipRecruiter
//
//  Created by Jean Paul Marinho on 06/05/17.
//  Copyright © 2017 aKANJ. All rights reserved.
//

import UIKit

class InterestCell: UICollectionViewCell {
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var imageBackground: UIImageView!
    
    override func awakeFromNib() {
        
        self.layer.cornerRadius = 10
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.2
        self.layer.shadowOffset = CGSize.zero
        self.layer.shadowRadius = 5
    }
}
