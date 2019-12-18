//
//  GearCategory.swift
//  HermitFinal
//
//  Created by Jean Paul dos Santos Marinho on 23/08/15.
//  Copyright (c) 2015 Jean Paul Marinho. All rights reserved.
//

import Foundation
import UIKit

var gearCategories = [GearCategory]()
var currentGearCategorySelectedIndex: Int?
var currentGearCategorySelected: GearCategory {
get {
    return gearCategories[currentGearCategorySelectedIndex!]
}
}
class GearCategory {
    var name: String?
    var imageOn: UIImage?
    var imageOff: UIImage?
    
    init (name: String) {
        self.name = name
    }
}