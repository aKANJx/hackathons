//
//  AppDelegate.swift
//  HackGrid
//
//  Created by Jean Paul Marinho on 14/09/19.
//  Copyright © 2019 aKANJ. All rights reserved.
//

import UIKit
import SwiftUI

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let contentView = HomeView()//MapView().edgesIgnoringSafeArea(.all)
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = UIHostingController(rootView: contentView)
        self.window = window
        APIClient.getPolicies()
        window.makeKeyAndVisible()
        return true
    }
}

