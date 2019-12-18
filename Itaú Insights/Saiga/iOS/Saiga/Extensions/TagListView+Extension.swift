//
//  TagListView+Extension.swift
//  Saiga
//
//  Created by Jean Paul Marinho on 26/08/18.
//  Copyright © 2018 Faganello. All rights reserved.
//

import Foundation
import TagListView
extension TagListView {
    
    class func config(view: TagListView) {
        view.textFont = UIFont.systemFont(ofSize: 11, weight: .semibold)
        view.paddingX = 5
        view.paddingY = 5
        view.cornerRadius = view.frame.height/5.0
        view.tagBackgroundColor = UIColor.hexStringToUIColor(hex: "55A773")
        view.textColor = UIColor.white
        view.alignment = .center
//        view.marginX = 10
//        view.marginY = 10
    }
}
