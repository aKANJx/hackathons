//
//  AppDelegate.swift
//  ChildShirtCA
//
//  Created by jeanpaul on 12/9/17.
//  Copyright © 2017 HackathonCA. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        UIApplication.shared.beginReceivingRemoteControlEvents()
        return true
    }
    
    override func remoteControlReceived(with event: UIEvent?) {
        print("entered")
    }

}

