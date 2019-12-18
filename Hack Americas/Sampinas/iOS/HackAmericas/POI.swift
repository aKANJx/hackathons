//
//  POI.swift
//  HackAmericas
//
//  Created by jeanpaul on 12/1/18.
//  Copyright © 2018 Jean Paul Marinho. All rights reserved.
//

import Foundation
import MapKit

class POI: NSObject, MKAnnotation {
    
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    
    init(pinTitle:String, pinSubTitle:String, location:CLLocationCoordinate2D) {
        self.title = pinTitle
        self.subtitle = pinSubTitle
        self.coordinate = location
    }
}
