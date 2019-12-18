//
//  CardViewController.swift
//  Fiesp5th
//
//  Created by Jean Paul Marinho on 16/10/16.
//  Copyright © 2016 aKANJ. All rights reserved.
//

import UIKit

class CardViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func createButtonPressed(_ sender: UIButton) {
        
        let chargeVC = SIMChargeCardViewController(publicKey: "sbpb_MmQzNTVjOWQtZTMzYy00NmNkLTk3NjEtNDUwMzE2ZThhYWRi")
        guard chargeVC != nil else {
            return
        }
        chargeVC!.delegate = self
        self.present(chargeVC!, animated: true, completion: nil)
    }
}



extension CardViewController: SIMChargeCardViewControllerDelegate {

    func chargeCardCancelled() {
    }

    func creditCardTokenFailedWithError(_ error: Error!) {
    }
    
    func creditCardTokenProcessed(_ token: SIMCreditCardToken!) {
            UIApplication.rootViewController(vcName: "RootNavigationController", storyboard: self.storyboard)
    }
}

