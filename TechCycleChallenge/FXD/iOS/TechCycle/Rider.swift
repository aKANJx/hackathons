//
//  Rider.swift
//  TechCycle
//
//  Created by Jean Paul Marinho on 23/09/17.
//  Copyright © 2017 aKANJ. All rights reserved.
//

import UIKit
import MapKit

class Rider: NSObject, MKAnnotation {
    
    var coordinate: CLLocationCoordinate2D
    var age: Int?
    var title: String?
    
    init(coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
    }
}
