//
//  Schedule.swift
//  HackAmericas
//
//  Created by jeanpaul on 12/1/18.
//  Copyright © 2018 Jean Paul Marinho. All rights reserved.
//

import Foundation

struct Schedule {
    
    var pickupAddress: String
    var destinationAddress: String
    var price: Double
    var imageName: String
    var hourType: Int
    
    init(pickupAddress: String, destinationAddress: String, price: Double, imageName: String, hourType: Int) {
        self.pickupAddress = pickupAddress
        self.destinationAddress = destinationAddress
        self.price = price
        self.imageName = imageName
        self.hourType = hourType
    }
}
