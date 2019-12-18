//
//  SettingsCell.swift
//  HackEMTU
//
//  Created by Jean Paul Marinho on 4/8/18.
//  Copyright © 2018 aKANJ. All rights reserved.
//

import Foundation
import UIKit

protocol SettingsCellDelegate {
    
    func actionPressed(button: UIButton)
}

class SettingsCell: UITableViewCell {
    
    @IBOutlet weak var actionButton: UIButton!
    var delegate: SettingsCellDelegate?
    
    @IBAction func actionPressed(_ sender: UIButton) {
        self.delegate?.actionPressed(button: sender)
    }
}
