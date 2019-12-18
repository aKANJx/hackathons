//
//  TagViewController.swift
//  AngelHackRio
//
//  Created by Jean Paul Marinho on 26/06/16.
//  Copyright © 2016 Jean Paul Marinho. All rights reserved.
//

import UIKit

class TagViewController: UIViewController {

    @IBOutlet weak var inputTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.inputTextField.font = UIFont.systemFont(ofSize: 11)
    }
        
    @IBAction func closeButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true) {
        }
    }
}
