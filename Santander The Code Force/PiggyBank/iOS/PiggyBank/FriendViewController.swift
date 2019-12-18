//
//  FriendViewController.swift
//  PiggyBank
//
//  Created by Jean Paul Marinho on 11/12/16.
//  Copyright © 2016 aKANJ. All rights reserved.
//

import UIKit

class FriendViewController: UIViewController {

    @IBAction func closePressed(_ sender: UIButton) {
        self.dismiss(animated: true)
        let vc = UIApplication.shared.keyWindow?.rootViewController?.childViewControllers.last as! HomeViewController
        vc.removeBlur()
    }
    
    @IBAction func sharePressed(_ sender: UIButton) {
        let shareText = "pigg.ly"
        let vc = UIActivityViewController(activityItems: [shareText], applicationActivities: [])
        present(vc, animated: true)
    }
}
