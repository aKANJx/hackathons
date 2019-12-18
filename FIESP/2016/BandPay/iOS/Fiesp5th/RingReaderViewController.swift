//
//  RingReaderViewController.swift
//  Fiesp5th
//
//  Created by Jean Paul Marinho on 16/10/16.
//  Copyright © 2016 aKANJ. All rights reserved.
//

import UIKit
import SwiftyJSON

class RingReaderViewController: UIViewController {

    var amount: Int!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        RingController.sharedInstance.requestAuthorization { (success) in
            if success {
                RingController.sharedInstance.delegate = self
            }
        }
    }
    
    func getRingData() {
        APIClient.ringData { (json, error) in
            if error == nil {
                RingController.sharedInstance.stopMonitoring()
                self.makePayment(json: json)
            }
        }
    }
    
    func makePayment(json: JSON) {
        APIClient.payment(json: json, amount: self.amount) { (success, error) in
            if error == nil {
                self.postResult(success: success)
            }
        }
    }
    
    func postResult(success: Bool) {
        var title: String
        var subtitle: String
        if success {
            title = "Obrigado!"
            subtitle = "Pagamento recebido com sucesso!"
        }
        else {
            title = "Erro!"
            subtitle = "Erro no recebimento do pagamento"
        }
        SweetAlert().showAlert(title, subTitle: subtitle, style: .success, buttonTitle: "OK") { (success) in
            self.navigationController?.popViewController(animated: true)
        }
    }
    
   
}



extension RingReaderViewController: RingControllerDelegate {
    func ringController(ringController: RingController, didFoundRing ring: Ring, withDistance distance: Double) {
        if distance <= 0.1 && distance > 0 {
            self.getRingData()
            RingController.sharedInstance.delegate = nil
        }
    }
}
