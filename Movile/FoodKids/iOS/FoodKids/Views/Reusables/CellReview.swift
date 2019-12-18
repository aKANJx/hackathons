//
//  CellReview.swift
//  FoodKids
//
//  Created by Marcos Vinicius Souza Lacerda on 19/08/2018.
//  Copyright © 2018 Expresso MovHack Expresso MovHack Expresso MovHack Expresso MovHack. All rights reserved.
//

import UIKit

protocol CellReviewDelegate {
    func buttonClicked()
}

class CellReview: UITableViewCell {

    var delegate: CellReviewDelegate?
    @IBOutlet weak var lbDate           : UILabel!
    @IBOutlet weak var lbDetailPrice    : UILabel!
    @IBOutlet weak var lbTotalPrice     : UILabel!
    @IBOutlet weak var btnReview        : UIButton!
    @IBOutlet weak var btnFinish        : UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureCell()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func finishPressed(_ sender: UIButton) {
        self.delegate?.buttonClicked()
    }
}


extension CellReview {
    
    fileprivate func configureCell() {
        
        btnFinish.layer.cornerRadius = 3
        btnFinish.layer.borderWidth  = 1
        btnFinish.layer.borderColor  = UIColor(red:0.27, green:0.69, blue:0.64, alpha:1.0).cgColor
        
        btnReview.layer.cornerRadius = 3
        btnReview.layer.borderWidth  = 1
        btnReview.layer.borderColor  = UIColor(red:0.27, green:0.69, blue:0.64, alpha:1.0).cgColor
    }
}
