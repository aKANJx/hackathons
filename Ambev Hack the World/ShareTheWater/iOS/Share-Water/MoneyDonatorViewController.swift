//
//  DonatorViewController.swift
//  Share-Water
//
//  Created by Jean Paul Marinho on 15/02/17.
//  Copyright © 2017 aKANJ. All rights reserved.
//

import UIKit
import EFSweetAlert

class MoneyDonatorViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func donatePressed(_ sender: UIButton) {
        let chargeVC = SIMChargeCardViewController(publicKey: "sbpb_MmQzNTVjOWQtZTMzYy00NmNkLTk3NjEtNDUwMzE2ZThhYWRi")
        chargeVC?.delegate = self
        self.present(chargeVC!, animated: true, completion: nil)
    }
    
    func creditCardHandler() {
        SweetAlert().showAlert("Tudo certo!", subTitle: "Obrigado por fazer o mundo um lugar melhor", style: .success, buttonTitle: "Desejo rastrear o caminhão") { (success) in
            //self.performSegue(withIdentifier: "ToDeliveryVC", sender: nil)
            let localNotification = UILocalNotification()
            localNotification.fireDate = Date.init(timeIntervalSinceNow: 10)
            localNotification.alertBody = "O caminhão de água com a sua doação já está partindo. Deseja acompanhá-lo?"
            UIApplication.shared.scheduleLocalNotification(localNotification)
        }
    }
}



extension MoneyDonatorViewController: SIMChargeCardViewControllerDelegate {
    func creditCardTokenProcessed(_ token: SIMCreditCardToken!) {
        print("Token: \(token)")
        creditCardHandler()
    }
    
    func chargeCardCancelled() {
    }
    
    func creditCardTokenFailedWithError(_ error: Error!) {
    }
}
