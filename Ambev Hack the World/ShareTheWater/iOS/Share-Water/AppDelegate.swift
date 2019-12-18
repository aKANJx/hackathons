//
//  AppDelegate.swift
//  Share-Water
//
//  Created by Jean Paul Marinho on 14/02/17.
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
        UIApplication.rootViewController(vcName: "DeliveryNavigationController", storyboard: storyboard)
    }
}

