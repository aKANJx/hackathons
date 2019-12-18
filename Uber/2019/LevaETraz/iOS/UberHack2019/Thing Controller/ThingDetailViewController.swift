//
//  ThingDetailViewController.swift
//  UberHack2019
//
//  Created by Jean Paul Marinho on 02/06/19.
//  Copyright © 2019 aKANJ. All rights reserved.
//

import UIKit

class ThingDetailViewController: UIViewController {

    var delegate: PanelActionsDelegate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    @IBAction func acceptPressed(_ sender: UIButton) {
        delegate?.nextScreen(from: 0, to: nil)
    }
}
