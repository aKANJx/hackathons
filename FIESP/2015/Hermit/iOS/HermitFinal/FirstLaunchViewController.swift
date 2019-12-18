//
//  FirstLaunchViewController.swift
//  
//
//  Created by Jean Paul dos Santos Marinho on 23/08/15.
//
//

import UIKit
import DigitsKit

class FirstLaunchViewController: UIViewController {
    
    @IBOutlet weak var createAccountButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func createAccountButtonPressed(sender: UIButton) {
        let digits = Digits.sharedInstance()
        digits.authenticateWithCompletion { (session, error) in
            // Inspect session/error objects
        }
    }
    @IBAction func appTourButtonPressed(sender: UIButton) {
        
        dismissViewControllerAnimated(true, completion: nil)
    }
}
