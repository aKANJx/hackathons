//
//  DashboardViewController.swift
//  Fiesp5th
//
//  Created by Jean Paul Marinho on 16/10/16.
//  Copyright © 2016 aKANJ. All rights reserved.
//

import UIKit

class DashboardViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    @IBAction func notificationButtonPressed(_ sender: UIButton) {
        print("Pressionou")
        let localNotification = UILocalNotification()
        //localNotification.timeZone = TimeZone(identifier: "GMT")
        localNotification.fireDate = Date.init(timeIntervalSinceNow: 10)
        localNotification.alertBody = "Pagamento processado! Deslize para mais detalhes..."
        UIApplication.shared.scheduleLocalNotification(localNotification)
    }
}
