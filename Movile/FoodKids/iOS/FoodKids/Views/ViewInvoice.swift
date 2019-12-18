//
//  ViewInvoice.swift
//  FoodKids
//
//  Created by Marcos Vinicius Souza Lacerda on 19/08/2018.
//  Copyright © 2018 Expresso MovHack Expresso MovHack Expresso MovHack Expresso MovHack. All rights reserved.
//

import UIKit

class ViewInvoice: UIView {

    @IBOutlet weak var lbTitle          : UILabel!
    @IBOutlet weak var lbSubTitle       : UILabel!
    @IBOutlet weak var lbTitlePrice     : UILabel!
    @IBOutlet weak var imgViewDollar    : UIImageView!
    @IBOutlet weak var lbDetailedPrice  : UILabel!
    @IBOutlet weak var lbTotalPrice     : UILabel!
    @IBOutlet weak var btnSummary       : UIButton!
    @IBOutlet weak var btnClose         : UIButton!
    
    override func layoutSubviews() {
      configureViews()
    }
    
    func setupData(with childName : String, restaurant : String, totalPrice : String, detailedPrice : String){
        
             lbSubTitle.text = "O restaurante \(restaurant) vai \nentregar as refeições das \nsemana para o \(childName) na \nsegunda-feira, ás 7h."
        
        lbDetailedPrice.text = "\(detailedPrice) por dia"
        
           lbTotalPrice.text = "\(totalPrice) pela semana"
    }
}


extension ViewInvoice {
    
    fileprivate func configureViews() {
        
    }
}
