//
//  CardView.swift
//  Torq
//
//  Created by Felipe Antonio Cardoso on 21/10/2018.
//  Copyright © 2018 aKANJ. All rights reserved.
//

import UIKit
import Koloda
import Cosmos
import AlamofireImage

class CardView: OverlayView {
    
    @IBOutlet weak var cardImage: UIImageView!
    @IBOutlet weak var cardTitle: UILabel!
    @IBOutlet weak var cardRate: CosmosView!
    @IBOutlet weak var cardPrice: UILabel!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = 20
        layer.borderColor = UIColor.darkGray.cgColor
        layer.borderWidth = 2.0
        clipsToBounds = true
    }

}
