//
//  ViewFeedback.swift
//  FoodKids
//
//  Created by Marcos Vinicius Souza Lacerda on 19/08/2018.
//  Copyright © 2018 Expresso MovHack Expresso MovHack Expresso MovHack Expresso MovHack. All rights reserved.
//

import UIKit
import FloatRatingView

class ViewFeedback: UIView {

    @IBOutlet weak var viewContent      : UIView!
    @IBOutlet weak var lbTitle          : UILabel!
    @IBOutlet weak var lbSubTitle       : UILabel!
    @IBOutlet weak var textView         : UITextView!
    @IBOutlet weak var floatRatingView  : FloatRatingView!
    @IBOutlet weak var lbTextViewTitle  : UILabel!
    @IBOutlet weak var btnSend          : UIButton!
    
    
    override func layoutSubviews() {
        configureViews()
    }
    
    func setupData(with childName : String){
        
           lbTitle.text                         = "O que o \(childName) está achando das \nsuas novas refeições?"
           lbTitle.numberOfLines                =  0
           lbTitle.adjustsFontSizeToFitWidth    = true
        
        lbSubTitle.text                         = "Pra gente, é muito importante ter o \nseu feedback e o do \(childName)."
        lbSubTitle.numberOfLines                = 0
        lbSubTitle.adjustsFontSizeToFitWidth    = true
        
    textView.layer.cornerRadius                 = 3
    textView.layer.borderWidth                  = 2
    textView.layer.borderColor                  = UIColor.gray.cgColor
    }
}

extension ViewFeedback {
    
    fileprivate func configureViews() {
        
        btnSend.layer.cornerRadius = 3
    }
}
