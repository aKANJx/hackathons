//
//  AddPiggyPrivacyTableViewCell.swift
//  Piggy
//
//  Created by Jean Paul Marinho on 12/01/17.
//  Copyright © 2017 aKANJ. All rights reserved.
//

import UIKit

class AddPiggyPrivacyCell: AddPiggyTableViewCell {

    @IBOutlet weak var isPublic: UISwitch!
    
    override func awakeFromNib() {
        self.delegate?.piggyUpdated(sender: self)
    }
    @IBAction func isPublicValueChanged(_ sender: UISwitch) {
        self.delegate?.piggyUpdated(sender: self)
    }
}
