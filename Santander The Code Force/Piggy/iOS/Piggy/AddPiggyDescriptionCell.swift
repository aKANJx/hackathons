//
//  AddPiggyDescriptionTableViewCell.swift
//  Piggy
//
//  Created by Jean Paul Marinho on 12/01/17.
//  Copyright © 2017 aKANJ. All rights reserved.
//

import UIKit

class AddPiggyDescriptionCell: AddPiggyTableViewCell {

    @IBOutlet weak var textView: UITextView!
    let placeholderMessage = "Descrição"
    
    override func awakeFromNib() {
        self.textView.delegate = self
        self.textView.text = self.placeholderMessage
    }
}



extension AddPiggyDescriptionCell: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        self.delegate?.piggyUpdated(sender: self)
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if textView.text == self.placeholderMessage {
            textView.text = ""
            textView.textColor = UIColor.black
            textView.text = text
        }
        return true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == "" {
            textView.text = "Descrição"
            textView.textColor = UIColor(hexString: "8D8D8D")
        }
    }
}
