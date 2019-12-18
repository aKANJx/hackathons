//
//  PiggysHeaderCell.swift
//  Piggy
//
//  Created by Jean Paul Marinho on 13/01/17.
//  Copyright © 2017 aKANJ. All rights reserved.
//

import Foundation
import UIKit

class PNavigationHeaderCell: PiggiesCell {
    
    @IBAction func createPressed(_ sender: UIButton) {
        self.delegate?.createPressed(sender: sender)
    }

    @IBAction func settingsPressed(_ sender: UIButton) {
        self.delegate?.settingsPressed(sender: sender)
    }
}
