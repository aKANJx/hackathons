//
//  LoginViewController.swift
//  Saiga
//
//  Created by Jean Paul Marinho on 26/08/18.
//  Copyright © 2018 Faganello. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet var continueButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.continueButton.applyDefaultStyle()
    }
}
