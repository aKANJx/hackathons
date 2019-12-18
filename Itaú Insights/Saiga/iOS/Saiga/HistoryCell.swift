//
//  HistoryCell.swift
//  Saiga
//
//  Created by Jean Paul Marinho on 26/08/18.
//  Copyright © 2018 Faganello. All rights reserved.
//

import UIKit

class HistoryCell: UITableViewCell {

    @IBOutlet var placeImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var addressLabel: UILabel!
    @IBOutlet var priceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.placeImageView.layer.cornerRadius = 12
        self.placeImageView.clipsToBounds = true
    }
}
