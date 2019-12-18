//
//  AbilityCell.swift
//  ZipRecruiter
//
//  Created by Jean Paul Marinho on 07/05/17.
//  Copyright © 2017 aKANJ. All rights reserved.
//

import UIKit

class AbilityCell: UICollectionViewCell {
    
    @IBOutlet weak var title: UILabel!
    
    override func awakeFromNib() {
        
        self.layer.cornerRadius = 10
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.2
        self.layer.shadowOffset = CGSize.zero
        self.layer.shadowRadius = 5
    }

}
