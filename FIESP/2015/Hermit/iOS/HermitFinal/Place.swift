//
//  Places.swift
//  HermitFinal
//
//  Created by Jean Paul dos Santos Marinho on 22/08/15.
//  Copyright (c) 2015 Jean Paul Marinho. All rights reserved.
//

import Foundation
import UIKit

//var currentPlace: String?

//var places: [String] {
//get {
//    let path = NSBundle.mainBundle().pathForResource("Places", ofType: "plist")
//    return NSArray(contentsOfFile: path!)! as! [String]
//}
//}
//
//var currentServiceColor: UIColor = UIColor(red: 248/255.0, green: 248/255.0, blue: 248/255.0, alpha: 1)
//var currentPlaceTitle: String = "Place"

var places = [Place]()
var currentPlaceSelectedIndex: Int?
var currentPlaceSelected: Place {
get {
    return places[currentPlaceSelectedIndex!]
}
}
class Place {
    var name: String?
    var image: UIImage?
    var coordinate: String?
   
    init (name: String) {
        self.name = name
    }
}