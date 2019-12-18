//
//  AddPiggyTableViewCell.swift
//  Piggy
//
//  Created by Jean Paul Marinho on 12/01/17.
//  Copyright © 2017 aKANJ. All rights reserved.
//

import UIKit

protocol AddPiggyDelegate {
    func createPressed(sender: UIButton)
    func piggyUpdated(sender: AddPiggyTableViewCell)
    func changedImagePressed(sender: UIButton)
}

class AddPiggyTableViewCell: UITableViewCell {
    
    var delegate: AddPiggyDelegate?

}
