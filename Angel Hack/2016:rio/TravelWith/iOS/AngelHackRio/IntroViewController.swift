//
//  LoginViewController.swift
//  AngelHackRio
//
//  Created by Jean Paul Marinho on 25/06/16.
//  Copyright © 2016 Jean Paul Marinho. All rights reserved.
//

import UIKit

class IntroViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    @IBAction func createAccountButtonPressed(_ sender: UIButton) {
    }
    
    @IBAction func facebookButtonPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "toSignupVC", sender: self)
//        APIClient.sharedInstance.login { (success) in
//            if success {
//                DispatchQueue.main.sync(execute: { 
//                })
//            }
//        }
    }
}
