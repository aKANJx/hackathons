//
//  KeeperAdViewController.swift
//  HackEMTU
//
//  Created by Jean Paul Marinho on 4/8/18.
//  Copyright © 2018 aKANJ. All rights reserved.
//

import UIKit

class KeeperAdViewController: UIViewController {

    var tabBarControllerRef: UITabBarController!
    @IBOutlet weak var topMessageLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func startPressed(_ sender: UIButton) {
        let vc = self.storyboard!.instantiateViewController(withIdentifier: "GarageVC")
        let tabBarItem = UITabBarItem(title: "Garage", image: UIImage(named: "icon-garage"), selectedImage: UIImage(named: "icon-garage"))
        vc.tabBarItem = tabBarItem
        self.tabBarControllerRef.viewControllers?.insert(vc, at: 1)
        self.dismiss(animated: true, completion: nil)
    }
}
