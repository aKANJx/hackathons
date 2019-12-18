//
//  UserLocation.swift
//  HermitFinal
//
//  Created by Jean Paul dos Santos Marinho on 23/08/15.
//  Copyright (c) 2015 Jean Paul Marinho. All rights reserved.
//

import Foundation
import CoreLocation

enum LocationMode: Int {
    case Automatic = 0
    case Manual = 1
    case None = 2
}

class UserLocation: NSObject {
    
    //MARK: - variables
    static let sharedInstance = UserLocation()
    let locationManager: CLLocationManager
    var userLocation: CLLocation?
    var userCoordinate: CLLocationCoordinate2D? {
        get {
            return userLocation?.coordinate
        }
    }
    
    //MARK: - methods
    override init() {
        locationManager = CLLocationManager()
        super.init()
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.distanceFilter = 100
    }
    
    func requestUserAuthorization() {
        locationManager.requestWhenInUseAuthorization()
    }
    
    func startUpdatingLocation() {
        locationManager.startUpdatingLocation()
    }
    
    func distanceFromProfessional(professionalCoordinate2D: CLLocationCoordinate2D) -> CLLocationDistance {
        let professionalLocation = CLLocation(latitude: professionalCoordinate2D.latitude, longitude: professionalCoordinate2D.longitude)
        let dist = (userLocation!.distance(from: professionalLocation) / 1000.0)
        return dist
    }
}




extension UserLocation: CLLocationManagerDelegate {
    private func locationManager(manager: CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == CLAuthorizationStatus.authorizedWhenInUse {
            startUpdatingLocation()
        }
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateToLocation newLocation: CLLocation!, fromLocation oldLocation: CLLocation!) {
        userLocation = newLocation
    }
}
