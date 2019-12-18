//
//  AppDelegate.swift
//  HackathonMetropolitana
//
//  Created by Jean Paul Marinho on 19/03/17.
//  Copyright © 2017 aKANJ. All rights reserved.
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
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "TransportController") as! TransportController
        vc.transportStep = 1
        UIApplication.shared.keyWindow?.rootViewController = nil
        UIApplication.shared.keyWindow?.rootViewController = vc
        vc.initCollect()
    }
    
}
