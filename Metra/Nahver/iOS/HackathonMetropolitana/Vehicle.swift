//
//  Vehicle.swift
//  HackathonMetropolitana
//
//  Created by Jean Paul Marinho on 19/03/17.
//  Copyright © 2017 aKANJ. All rights reserved.
//

import Foundation
import MapKit
import CoreLocation

class Vehicle: NSObject, MKAnnotation {
    
    let title: String?
    var coordinate: CLLocationCoordinate2D
    let routeCoordinates: [CLLocationCoordinate2D]
    var currentCoordinateIndex = 0
    
    init(routeCoordinates: [CLLocationCoordinate2D]) {
        self.title = "Vehicle"
        self.coordinate = routeCoordinates.first!
        self.routeCoordinates = routeCoordinates
    }

    init(coordinate: CLLocationCoordinate2D) {
        self.title = "Vehicle"
        self.routeCoordinates = [coordinate]
        self.coordinate = coordinate
    }
    
    func updateCoordinate() {
        self.coordinate = self.routeCoordinates[self.currentCoordinateIndex]
    }
    
    class func vehicles() -> [Vehicle] {
        return [Vehicle(coordinate: CLLocationCoordinate2D(latitude: -23.663207, longitude: -46.563777)),
        Vehicle(coordinate: CLLocationCoordinate2D(latitude: -23.629090, longitude: -46.629811)),
        Vehicle(coordinate: CLLocationCoordinate2D(latitude: -23.616540, longitude: -46.569379)),
        Vehicle(coordinate: CLLocationCoordinate2D(latitude: -23.675589, longitude: -46.523987)),
        Vehicle(coordinate: CLLocationCoordinate2D(latitude: -23.630321, longitude: -46.604967)),
        Vehicle(coordinate: CLLocationCoordinate2D(latitude: -23.595497, longitude: -46.561590)),
        Vehicle(coordinate: CLLocationCoordinate2D(latitude: -23.646806, longitude: -46.642569))]
    }
}
