//
//  HomeTableViewCell.swift
//  
//
//  Created by Jean Paul dos Santos Marinho on 22/08/15.
//
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cardImage: UIImageView!

    func putCardImage(cardImage: UIImage) {
        self.cardImage.image = cardImage
    }
}
