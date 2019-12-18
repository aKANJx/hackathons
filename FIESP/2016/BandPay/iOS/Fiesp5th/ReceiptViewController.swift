//
//  ReceiptViewController.swift
//  Fiesp5th
//
//  Created by Jean Paul Marinho on 16/10/16.
//  Copyright © 2016 aKANJ. All rights reserved.
//

import UIKit

class ReceiptViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }

    override func viewWillAppear(_ animated: Bool) {
        APIClient.receipt { (error) in
            if error == nil {
                
            }
        }
    }
}
