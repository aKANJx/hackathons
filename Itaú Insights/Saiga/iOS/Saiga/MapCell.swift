//
//  MapCell.swift
//  Saiga
//
//  Created by Jean Paul Marinho on 26/08/18.
//  Copyright © 2018 Faganello. All rights reserved.
//

import UIKit
import TagListView
class MapCell: UICollectionViewCell {
    
    @IBOutlet weak var money: UILabel!
    @IBOutlet var roundedView: UIView!
    @IBOutlet var stackView: UIStackView!
    @IBOutlet var myPlaceView: UIView!
    @IBOutlet var myContentView: UIView!
    @IBOutlet var tagListView: TagListView!
    @IBOutlet var myLocationLabel: UILabel!
    @IBOutlet var goToButton: UIButton!
    
    @IBOutlet weak var popCorn: UILabel!
    @IBOutlet weak var drink: UILabel!
    @IBOutlet weak var corn: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.roundedView.layer.cornerRadius = 12
        self.roundedView.layer.masksToBounds = false
        self.roundedView.layer.shadowColor = UIColor.black.cgColor
        self.roundedView.layer.shadowOpacity = 0.6
        self.roundedView.layer.shadowOffset = CGSize.zero
        self.roundedView.layer.shadowRadius = 5
        self.roundedView.layer.shadowPath = UIBezierPath(rect: self.roundedView.bounds).cgPath
        TagListView.config(view: self.tagListView)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.tagListView.removeAllTags()
    }
}
