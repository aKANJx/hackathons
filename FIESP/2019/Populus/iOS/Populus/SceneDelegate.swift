//
//  SceneDelegate.swift
//  Populus
//
//  Created by Jean Paul Marinho on 28/08/19.
//  Copyright © 2019 aKANJ. All rights reserved.
//

import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    var state = 0
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        let contentView = HomeView()
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = UIHostingController(rootView: contentView)
            self.window = window
            window.makeKeyAndVisible()
        }
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        if state == 1 {
            if let windowScene = scene as? UIWindowScene {
                let window = UIWindow(windowScene: windowScene)
                window.rootViewController = UIHostingController(rootView: IdentityView())
                self.window = window
                window.makeKeyAndVisible()
            }
        }
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        let content = UNMutableNotificationContent()
        content.title = "Populus"
        content.subtitle = "Solicitação de Identidade"
        content.body = "Abra o app e decida o que deseja compartilhar com o solicitante..."
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        let request = UNNotificationRequest(identifier: "notification.id.01", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        self.state = 1
    }
}

