//
//  AKFThemeExtension.swift
//  fiesp5th
//
//  Created by Jean Paul Marinho on 15/10/16.
//  Copyright © 2016 aKANJ. All rights reserved.
//

import Foundation
import AccountKit

extension AKFTheme {
    class func basicTheme() -> AKFTheme {
        let theme:AKFTheme = AKFTheme.default()
        theme.headerBackgroundColor = UIColor(red: 44/255.0, green: 62/255.0, blue: 80/255.0, alpha: 1.0)
        theme.headerTextColor = UIColor.white
        theme.iconColor = UIColor(red: 0.325, green: 0.557, blue: 1, alpha: 1)
        theme.inputTextColor = UIColor(white: 0.4, alpha: 1.0)
        theme.statusBarStyle = .lightContent
        theme.textColor = UIColor(white: 0.3, alpha: 1.0)
        theme.titleColor = UIColor(red: 0.247, green: 0.247, blue: 0.247, alpha: 1)
        theme.buttonTextColor = UIColor.white
        theme.buttonBackgroundColor = UIColor(red: 70/255.0, green: 170/255.0, blue: 185/255.0, alpha: 1.0)
        return theme
    }
}
