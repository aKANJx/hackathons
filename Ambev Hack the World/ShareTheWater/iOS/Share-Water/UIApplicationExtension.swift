//
//  UIApplicationExtension.swift
//  Fiesp5th
//
//  Created by Jean Paul Marinho on 16/10/16.
//  Copyright © 2016 aKANJ. All rights reserved.
//

import Foundation
import UIKit

extension UIApplication {
    class func rootViewController(vcName: String, storyboard: UIStoryboard?) {
        guard storyboard != nil else {
            return
        }
        let vc = storyboard!.instantiateViewController(withIdentifier: vcName)
        guard vc != nil else {
            return
        }
        UIApplication.shared.keyWindow?.rootViewController = vc
    }
}
