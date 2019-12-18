//
//  SwimmerListTableViewCell.swift
//  
//
//  Created by Jean Paul dos Santos Marinho on 22/08/15.
//
//

import UIKit

class SwimmerListTableViewCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var profilePhotoView: PhotoView!
    
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var star0: UIImageView!
    @IBOutlet weak var star1: UIImageView!
    @IBOutlet weak var star2: UIImageView!
    @IBOutlet weak var star3: UIImageView!
    @IBOutlet weak var star4: UIImageView!
}
