//
//  Gear.swift
//  HermitFinal
//
//  Created by Jean Paul dos Santos Marinho on 22/08/15.
//  Copyright (c) 2015 Jean Paul Marinho. All rights reserved.
//

import Foundation
import UIKit

//var gears = [Gear]()
//var currentGearSelectedIndex: Int?
//var currentGearSelected: Gear {
//get {
//    return gears[currentGearSelectedIndex!]
//}
//}

class Gear {
    var title: String?
    var subtitle: String?
    var category: String?
    var description: String?
    var image: UIImage?
    var price: String?
    var place: String?
    var isAvailable: Bool?

    var evaluationQuantity: Int?
    var evaluationSum: Int?
    
    init (title: String) {
        self.title = title
    }
}
