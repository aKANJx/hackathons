//
//  AddPiggyButtonTableViewCell.swift
//  Piggy
//
//  Created by Jean Paul Marinho on 12/01/17.
//  Copyright © 2017 aKANJ. All rights reserved.
//

import UIKit


class AddPiggyCreateCell: AddPiggyTableViewCell {
        
    @IBAction func createPressed(_ sender: UIButton) {
        delegate?.createPressed(sender: sender)
    }
}
