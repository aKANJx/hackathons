//
//  AppDelegate.swift
//  fiesp5th
//
//  Created by Jean Paul Marinho on 15/10/16.
//  Copyright © 2016 aKANJ. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        let settings = UIUserNotificationSettings(types: [.alert , .sound, .badge], categories: nil)
        application.registerUserNotificationSettings(settings)
        return true
    }
    
    func application(_ application: UIApplication, didReceive notification: UILocalNotification) {
        let storyboard = UIStoryboard(name: "Consumer", bundle: nil)
        UIApplication.rootViewController(vcName: "ReceiptViewController", storyboard: storyboard)
    }
}
