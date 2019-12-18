//
//  Swimmer.swift
//  HermitFinal
//
//  Created by Jean Paul dos Santos Marinho on 22/08/15.
//  Copyright (c) 2015 Jean Paul Marinho. All rights reserved.
//

import Foundation
import UIKit

var swimmers = [Swimmer]()
var currentSwimmerSelectedIndex: Int?
var currentSwimmerSelected: Swimmer {
get {
    return swimmers[currentSwimmerSelectedIndex!]
}
}
class Swimmer {
    var name: String?
    var photo: UIImage?
    var phone: String?
    var mail: String?
    var certificationNumber: String?
    var gears: [Gear]?
    var swimmerDescription: String?
    var evaluationQuantity: Int?
    var evaluationSum: Int?
    
    init (name: String) {
        self.name = name
        gears = [Gear]()
    }
}