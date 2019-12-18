//
//  HUDView.swift
//  HackathonMetropolitana
//
//  Created by Jean Paul Marinho on 19/03/17.
//  Copyright © 2017 aKANJ. All rights reserved.
//

import UIKit

class HUDView: UIView {
    
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var collectDistanceLabel: UILabel!
    @IBOutlet weak var countdownLabel: UILabel!

    override func awakeFromNib() {
        let strokeTextAttributes = [
            NSStrokeColorAttributeName : UIColor.black,
            NSForegroundColorAttributeName : UIColor.white,
            NSStrokeWidthAttributeName : -0.5,
            NSFontAttributeName : UIFont.boldSystemFont(ofSize: 21)
            ] as [String : Any]
        
        self.headerLabel.attributedText = NSMutableAttributedString(string: "Vá para o ponto indicado no mapa para o embarque", attributes: strokeTextAttributes)
    }
}
