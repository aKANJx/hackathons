//
//  PaymentViewController.swift
//  Abramit
//
//  Created by Jean Paul Marinho on 15/11/17.
//  Copyright © 2017 aKANJ. All rights reserved.
//

import UIKit
import Cards

class PaymentViewController: UIViewController {

    @IBOutlet var cardView1: CardHighlight!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        let cardContentVC = storyboard!.instantiateViewController(withIdentifier: "CardContent")
        self.cardView1.shouldPresent(cardContentVC, from: self)
    }
}


extension PaymentViewController: CardDelegate {
    
}
