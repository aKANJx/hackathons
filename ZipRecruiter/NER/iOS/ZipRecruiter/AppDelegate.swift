//
//  AppDelegate.swift
//  ZipRecruiter
//
//  Created by Jean Paul Marinho on 06/05/17.
//  Copyright © 2017 aKANJ. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        let center = UNUserNotificationCenter.current()
        let options: UNAuthorizationOptions = [.alert, .sound];
        center.requestAuthorization(options: options) {
            (granted, error) in
            if !granted {
                print("Something went wrong")
            }
        }
        return true
    }
    
}

