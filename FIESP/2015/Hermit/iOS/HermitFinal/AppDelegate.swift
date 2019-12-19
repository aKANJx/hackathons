//
//  AppDelegate.swift
//  HermitFinal
//
//  Created by Jean Paul dos Santos Marinho on 22/08/15.
//  Copyright (c) 2015 Jean Paul Marinho. All rights reserved.
//

import UIKit
import Parse
import Bolts

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        Parse.enableLocalDatastore()
        // Initialize Parse.
        Parse.setApplicationId("hFLKvV7gy77H3Sc3bDUDKshYPgDxElxu8W7EvlUY",
            clientKey: "31Yv8w6PfTUt8C6jUv1gA0wzYVm4JdSyaVBD1oNZ")
        return true
    }
}
