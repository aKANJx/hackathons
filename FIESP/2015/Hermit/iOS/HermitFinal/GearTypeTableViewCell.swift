//
//  GearTypeTableViewCell.swift
//  
//
//  Created by Jean Paul dos Santos Marinho on 22/08/15.
//
//

import UIKit

class GearTypeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cardImage: UIImageView!
    var selectedCard: Bool = false
    
    func putCardImage(cardImage: UIImage) {
        self.cardImage.image = cardImage
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}
