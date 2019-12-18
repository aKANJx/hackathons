//
//  AppDelegate.swift
//  UberHack2019
//
//  Created by Jean Paul Marinho on 02/06/19.
//  Copyright © 2019 aKANJ. All rights reserved.
//

import UIKit
import UserNotifications


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let notificationCenter = UNUserNotificationCenter.current()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
        notificationCenter.requestAuthorization(options: options) {
            (didAllow, error) in
            if !didAllow {
                print("User has declined notifications")
            }
        }
        return true
    }
    
    func scheduleNotification(notificationType: String) {
        
        let content = UNMutableNotificationContent()
        
        content.title = notificationType
        content.body = "Maria Augusta fez uma solicitação para você! Toque para saber mais..."
        content.sound = UNNotificationSound.default
        content.badge = nil
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        let identifier = "Local Notification"
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        
        notificationCenter.add(request) { (error) in
            if let error = error {
                print("Error \(error.localizedDescription)")
            }
        }
    }
}

