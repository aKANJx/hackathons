//
//  RootTabBarController.swift
//  SHIFT
//
//  Created by Jean Paul Marinho on 11/06/16.
//  Copyright © 2016 Jean Paul Marinho. All rights reserved.
//

import UIKit

class RootTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.tintColor = UIColor(red: 44/255.0, green: 62/255.0, blue: 80/255.0, alpha: 1.0)
//        self.tabBarController?.delegate = self
    }
}



//extension RootTabBarController: UITabBarControllerDelegate {
//    func tabBarController(tabBarController: UITabBarController, didSelectViewController viewController: UIViewController) {
//        if self.selectedIndex == 1 {
//            viewController.navigationController?.popToRootViewControllerAnimated(false)
//        }
//    }
//}