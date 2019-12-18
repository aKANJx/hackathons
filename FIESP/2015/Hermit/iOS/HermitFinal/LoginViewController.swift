//
//  LoginViewController.swift
//  
//
//  Created by Jean Paul dos Santos Marinho on 23/08/15.
//
//

import UIKit
import DigitsKit

class LoginViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let authenticateButton = DGTAuthenticateButton(authenticationCompletion: {
            (session: DGTSession!, error: NSError!) in
            // play with Digits session
        })
        authenticateButton.center = self.view.center
        self.view.addSubview(authenticateButton)
    }
}