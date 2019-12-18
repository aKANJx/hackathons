//
//  PairViewController.swift
//  Fiesp5th
//
//  Created by Jean Paul Marinho on 15/10/16.
//  Copyright © 2016 aKANJ. All rights reserved.
//

import UIKit

class PairViewController: UIViewController {

    @IBOutlet weak var ringButton: UIButton!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        RingController.sharedInstance.requestAuthorization { (success) in
            if success {
                RingController.sharedInstance.delegate = self
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        RingController.sharedInstance.stopMonitoring()
    }
    
    @IBAction func ringButtonPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "toCardVC", sender: nil)
    }
    
    @IBAction func skipButtonPressed(_ sender: UIButton) {
        UIApplication.rootViewController(vcName: "RootNavigationController", storyboard: self.storyboard)
    }
}



extension PairViewController: RingControllerDelegate {
    func ringController(ringController: RingController, didFoundRing ring: Ring, withDistance distance: Double) {
        if distance <= 0.1 && distance > 0 {
            self.ringButton.isHidden = false
        }
    }
}
