//
//  GPSController.swift
//  ShareTheWater
//
//  Created by Jean Paul Marinho on 26/11/16.
//  Copyright © 2016 aKANJ. All rights reserved.
//

import Foundation
import CoreLocation

protocol GPSControllerDelegate {
    func updatedUserLocationCoordinate(_ coordinate: CLLocationCoordinate2D)
}

class GPSController: NSObject {
    
    static let sharedInstance = GPSController()
    fileprivate let locationManager = CLLocationManager()
    var authorizationCallback: ((_ success: Bool) -> ())?
    var delegate: GPSControllerDelegate?

    override init() {
        super.init()
        self.locationManager.delegate = self
    }
    
    func requestAuthorization(_ completion: @escaping(Bool) -> ()) {
        self.authorizationCallback = completion
        self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        self.locationManager.requestWhenInUseAuthorization()
    }
}


extension GPSController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedWhenInUse:
            self.authorizationCallback?(true)
            locationManager.startUpdatingLocation()
            break
        case .denied:
            self.authorizationCallback?(false)
            break
        default:
            return
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.delegate?.updatedUserLocationCoordinate((locations.first?.coordinate)!)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        print(newHeading.magneticHeading)
    }
}
