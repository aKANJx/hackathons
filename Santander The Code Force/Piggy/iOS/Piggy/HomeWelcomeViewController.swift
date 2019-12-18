//
//  HomeWelcomeViewController.swift
//  Piggy
//
//  Created by Jean Paul Marinho on 16/01/17.
//  Copyright © 2017 aKANJ. All rights reserved.
//

import UIKit
import GhostTypewriter

class HomeWelcomeViewController: UIViewController {
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var message1: TypewriterLabel!
    @IBOutlet weak var message2: TypewriterLabel!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.message1.typingTimeInterval = 0.01
        self.message2.typingTimeInterval = 0.01
        self.contentView.alpha = 0
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animate(withDuration: 0.5, animations: {
            self.contentView.alpha = 1
        }) { (success) in
            self.message1.startTypewritingAnimation(completion: {
                self.message2.startTypewritingAnimation(completion: {
                    Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { timer in
                        UserDefaults.standard.set(true, forKey: "loggedUser")
                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "RootTabBarController")
                        UIApplication.shared.keyWindow?.rootViewController = vc
                    }
                })
            })
        }
    }
}
