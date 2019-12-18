//
//  WelcomeViewController.swift
//  Piggy
//
//  Created by Jean Paul Marinho on 13/01/17.
//  Copyright © 2017 aKANJ. All rights reserved.
//

import UIKit
import GhostTypewriter

class PiggyAdvisorViewController: UIViewController {

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var adviceMessage: TypewriterLabel!
    @IBOutlet weak var letsGoButton: AppButton!
        
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.adviceMessage.typingTimeInterval = 0.015
        self.contentView.alpha = 0
        self.letsGoButton.alpha = 0
        self.letsGoButton.isEnabled = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animate(withDuration: 0.5, animations: {
            self.contentView.alpha = 1
        }) { (success) in
            self.adviceMessage.startTypewritingAnimation(completion: {
                UIView.animate(withDuration: 1, animations: { 
                    self.letsGoButton.alpha = 1
                    self.letsGoButton.isEnabled = true
                })
            })
        }
    }
    
    @IBAction func letsGoPressed(_ sender: UIButton) {
        UIView.animate(withDuration: 0.5, animations: {
            self.contentView.alpha = 0
        }, completion: { (success) in
            self.performSegue(withIdentifier: "ToCreatePersonalPiggyVC", sender: nil)
        })
    }
}
