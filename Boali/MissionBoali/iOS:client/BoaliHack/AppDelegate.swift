//
//  AppDelegate.swift
//  BoaliHack
//
//  Created by Jean Paul Marinho on 24/08/19.
//  Copyright © 2019 aKANJ. All rights reserved.
//

import UIKit
import SwiftUI


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

          // Create the SwiftUI view that provides the window contents.
          let contentView = CatalogView()

          // Use a UIHostingController as window root view controller.
          let window = UIWindow(frame: UIScreen.main.bounds)
          window.rootViewController = UIHostingController(rootView: contentView)
          self.window = window
          window.makeKeyAndVisible()
          return true
      }
}

