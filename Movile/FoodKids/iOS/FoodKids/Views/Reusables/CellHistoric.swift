//
//  CellHistoric.swift
//  FoodKids
//
//  Created by Marcos Vinicius Souza Lacerda on 19/08/2018.
//  Copyright © 2018 Expresso MovHack Expresso MovHack Expresso MovHack Expresso MovHack. All rights reserved.
//

import UIKit

class CellHistoric: UITableViewCell {

    @IBOutlet weak var lbDate           : UILabel!
    @IBOutlet weak var lbDetailPrice    : UILabel!
    @IBOutlet weak var lbTotalPrice     : UILabel!
    @IBOutlet weak var btnView          : UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}


extension CellHistoric {
    
    fileprivate func configureCell() {
        
        btnView.layer.cornerRadius = 3
        btnView.layer.borderWidth  = 1
        btnView.layer.borderColor  = UIColor(red:0.27, green:0.69, blue:0.64, alpha:1.0).cgColor
    }
}
