//
//  GuideTableViewCell.swift
//  AngelHackRio
//
//  Created by Jean Paul Marinho on 25/06/16.
//  Copyright © 2016 Jean Paul Marinho. All rights reserved.
//

import UIKit

class GuideTableViewCell: UITableViewCell {

    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var placeLabel: UILabel!
    @IBOutlet weak var graphicView: GraphicView!
    @IBOutlet weak var starValueLabel: UILabel!
    @IBOutlet weak var exploreImageView: UIImageView!
    @IBOutlet weak var exploreValueLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.photoImageView.layer.cornerRadius = self.photoImageView.frame.size.height/2.0
        self.photoImageView.clipsToBounds = true
        self.photoImageView.setNeedsDisplay()
        let imageIcon = UIImage(named: "icon-world")
        imageIcon?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        self.exploreImageView.image = imageIcon
        self.exploreImageView.tintColor = UIColor.white()

    }
}
