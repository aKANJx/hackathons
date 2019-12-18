//
//  PShareCell.swift
//  Piggy
//
//  Created by Jean Paul Marinho on 17/01/17.
//  Copyright © 2017 aKANJ. All rights reserved.
//

import UIKit

protocol PShareCellDelegate {
    func sharePressed()
}

class PShareCell: UITableViewCell {

    var delegate: PShareCellDelegate?
    
    @IBAction func sharePressed(_ sender: UIButton) {
        self.delegate?.sharePressed()
    }
    
}
