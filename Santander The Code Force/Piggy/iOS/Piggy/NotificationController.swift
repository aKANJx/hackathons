//
//  Notifications.swift
//  Piggy
//
//  Created by Jean Paul Marinho on 12/01/17.
//  Copyright © 2017 aKANJ. All rights reserved.
//

import Foundation
import UIKit

class NotificationController {
    
    static let shared = NotificationController()
    private var loadingIndicator: AASquaresLoading!
    
    func showLoadingIndicator(view: UIView) {
        self.loadingIndicator = AASquaresLoading(target: view, size: 50)
        self.loadingIndicator.color = UIColor(hexString: "fc4463")!
        self.loadingIndicator.start()
    }
    
    func removeLoadingIndicator() {
        self.loadingIndicator.stop()
    }
    
    func showAlert(viewController: UIViewController, title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(alertAction)
        viewController.present(alertController, animated: true, completion: nil)
        
    }
    
    func showActivity(viewController: UIViewController) {
        let activityViewController = UIActivityViewController(activityItems: ["Piggy"], applicationActivities: nil)
        viewController.present(activityViewController, animated: true, completion: nil)
    }
}
