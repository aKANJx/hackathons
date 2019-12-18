//
//  ScheduleCell.swift
//  HackAmericas
//
//  Created by jeanpaul on 12/1/18.
//  Copyright © 2018 Jean Paul Marinho. All rights reserved.
//

import UIKit

class ScheduleCell: UICollectionViewCell {
    
    @IBOutlet var panelView: UIView!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var pickupAddressLabel: UILabel!
    @IBOutlet var destinationAddressLabel: UILabel!
    @IBOutlet var priceLabel: UILabel!
    @IBOutlet var hourTypeView: UIImageView!
    
    override func awakeFromNib() {
        panelView.layer.roundCorners(radius: 12)
        panelView.layer.addShadow()
    }
}
