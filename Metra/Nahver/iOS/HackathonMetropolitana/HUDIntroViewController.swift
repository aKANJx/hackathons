//
//  HUDIntroViewController.swift
//  HackathonMetropolitana
//
//  Created by Jean Paul Marinho on 19/03/17.
//  Copyright © 2017 aKANJ. All rights reserved.
//

import UIKit
import DateTimePicker
import Hex
class HUDIntroViewController: UIViewController {
    
    @IBAction func createOrderPressed(_ sender: UIButton) {
        let picker = DateTimePicker.show()
        picker.highlightColor = UIColor(hex: "64538C")
        picker.completionHandler = { date in
            SweetAlert().showAlert("Viagem reservada!", subTitle: "Você receberá uma notificação quando o veículo estiver se aproximando", style: .success, buttonTitle:"OK! :)", buttonColor:UIColor(hex: "64538C")) { (isOtherButton) -> Void in
                let localNotification = UILocalNotification()
                localNotification.fireDate = Date.init(timeIntervalSinceNow: 10)
                localNotification.alertBody = "O seu veículo já está a caminho! Toque para mais detalhes"
                UIApplication.shared.scheduleLocalNotification(localNotification)
            }
        }
    }
}
