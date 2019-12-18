//
//  BroadcastViewController.swift
//  Torq
//
//  Created by Jean Paul Marinho on 21/10/18.
//  Copyright © 2018 aKANJ. All rights reserved.
//

import UIKit
import Lottie
import UserNotifications

class BroadcastViewController: UIViewController {

    @IBOutlet var lottieContainerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UNUserNotificationCenter.current().delegate = self
        let lottieView = AnimationView(name: "radar")
        lottieView.play()
        lottieView.frame = lottieContainerView.bounds
        lottieContainerView.addSubview(lottieView)
        lottieView.contentMode = .scaleAspectFit
        lottieView.loopMode = .loop
        // Do any additional setup after loading the view.
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge], completionHandler: {didAllow, error in
            //creating the notification content
            let content = UNMutableNotificationContent()
            
            //adding title, subtitle, body and badge
            content.title = "Torq"
            content.subtitle = "Eei, encontramos alguns carros que batem com seu perfil."
            content.body = "Toque para ver..."
            content.badge = 1
            
            //getting the notification trigger
            //it will be called after 5 seconds
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 15, repeats: false)
            
            //getting the notification request
            let request = UNNotificationRequest(identifier: "SimplifiedIOSNotification", content: content, trigger: trigger)
            
            //adding the notification to notification center
            UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        })
    }
}


extension BroadcastViewController: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        self.performSegue(withIdentifier: "toCardsVC", sender: nil)
    }
}
