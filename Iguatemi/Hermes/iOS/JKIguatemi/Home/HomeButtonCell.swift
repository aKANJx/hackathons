//
//  HomeButtonCell.swift
//  JKIguatemi
//
//  Created by Jean Paul Marinho on 23/09/18.
//  Copyright © 2018 aKANJ. All rights reserved.
//

import UIKit

protocol HomeButtonCellDelegate {
    
    func scanPressed()
}

class HomeButtonCell: UITableViewCell {

    var delegate: HomeButtonCellDelegate?
    
    @IBAction func scanPressed(_ sender: UIButton) {
        delegate?.scanPressed()
    }
}
