//
//  Thing.swift
//  UberHack2019
//
//  Created by Jean Paul Marinho on 02/06/19.
//  Copyright © 2019 aKANJ. All rights reserved.
//

import Foundation
import MapKit


class Place: NSObject, MKAnnotation {
    
    var coordinate: CLLocationCoordinate2D
    var title: String?
    
    init(coordinate: CLLocationCoordinate2D, title: String) {
        self.coordinate = coordinate
        self.title = title
    }
}
