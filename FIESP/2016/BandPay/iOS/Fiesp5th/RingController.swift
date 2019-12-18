//
//  BeaconController.swift
//  Fiesp5th
//
//  Created by Jean Paul Marinho on 15/10/16.
//  Copyright © 2016 aKANJ. All rights reserved.
//

import Foundation
import CoreLocation

protocol RingControllerDelegate {
    func ringController(ringController: RingController, didFoundRing ring:Ring, withDistance distance: Double)
}

struct Ring {
    var identifier: String
}

class RingController: NSObject {
    static let sharedInstance = RingController()
    private let locationManager = CLLocationManager()
    var authorizationCallback: ((_ success: Bool) -> ())?
    var delegate: RingControllerDelegate?
    let beaconRegion = CLBeaconRegion(proximityUUID: NSUUID(uuidString: "f7826da6-4fa2-4e98-8024-bc5b71e0893e")! as UUID, identifier: "Fiesp5th")
    
    override init() {
        super.init()
        self.locationManager.delegate = self
    }
    
    func requestAuthorization(completion: @escaping(Bool) -> ()) {
        self.authorizationCallback = completion
        self.locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        self.locationManager.requestWhenInUseAuthorization()
    }
    
    func stopMonitoring() {
        self.locationManager.stopRangingBeacons(in: beaconRegion)
    }
}


extension RingController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedWhenInUse:
            manager.startRangingBeacons(in: beaconRegion)
            self.authorizationCallback?(true)
            break
        case .denied:
            self.authorizationCallback?(false)
            break
        default:
            return
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
        guard let beacon = beacons.first else {
            return
        }
        let identifier = "\(beacon.minor)X\(beacon.major)"
        let distance = beacon.accuracy
        print(distance)
        let ring = Ring(identifier: identifier)
        self.delegate?.ringController(ringController: self, didFoundRing: ring, withDistance: distance)
    }
}
