//
//  AddPiggyHeaderTableViewCell.swift
//  Piggy
//
//  Created by Jean Paul Marinho on 12/01/17.
//  Copyright © 2017 aKANJ. All rights reserved.
//

import UIKit

class AddPiggyHeaderCell: AddPiggyTableViewCell {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var imageButton: UIButton!

    override func awakeFromNib() {
        self.nameTextField.delegate = self
        self.nameTextField.attributedPlaceholder = NSAttributedString(string: "Nome do Piggy", attributes: [NSForegroundColorAttributeName: UIColor(hexString: "8D8D8D")!])
    }
    
    @IBAction func imagePressed(_ sender: UIButton) {
        self.delegate?.changedImagePressed(sender: sender)
    }
}



extension AddPiggyHeaderCell: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.delegate?.piggyUpdated(sender: self)
    }
}

