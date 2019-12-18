//
//  OrderCell.swift
//  BoaliPDV
//
//  Created by Jean Paul Marinho on 25/08/19.
//  Copyright © 2019 aKANJ. All rights reserved.
//

import UIKit

class OrderCell: UICollectionViewCell {
    
    @IBOutlet var itemsLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var cellNumberLabel: UILabel!
    
    override func awakeFromNib() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
        dateLabel.text = dateFormatter.string(from: Date())
    }
}
