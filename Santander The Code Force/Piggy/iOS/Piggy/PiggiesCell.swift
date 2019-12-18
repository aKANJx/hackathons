//
//  PiggysTableViewCell.swift
//  Piggy
//
//  Created by Jean Paul Marinho on 13/01/17.
//  Copyright © 2017 aKANJ. All rights reserved.
//

import UIKit


protocol PiggiesCellDelegate {
    func createPressed(sender: UIButton)
    func settingsPressed(sender: UIButton)
}

class PiggiesCell: UICollectionViewCell {

    var delegate: PiggiesCellDelegate?

}
