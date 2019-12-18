//
//  TransportController.swift
//  HackathonMetropolitana
//
//  Created by Jean Paul Marinho on 19/03/17.
//  Copyright © 2017 aKANJ. All rights reserved.
//

import UIKit
import CoreLocation

class TransportController: UIViewController {

    let locationManager = CLLocationManager()
    var mapVC: MapViewController!
    var hudIntroVC: HUDIntroViewController!
    var hudCollectVC: HUDCollectViewController!
    var transportStep = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.locationManager.delegate  = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        self.locationManager.distanceFilter = 100
        self.locationManager.requestWhenInUseAuthorization()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.mapVC = self.storyboard?.instantiateViewController(withIdentifier: "MapViewController") as! MapViewController!
        self.addChildViewController(self.mapVC)
        self.view.addSubview(self.mapVC.view)
        self.mapVC.didMove(toParentViewController: self)
        switch self.transportStep {
        case 0:
            self.mapVC.loadVehicles()
            self.hudIntroVC = self.storyboard?.instantiateViewController(withIdentifier: "HUDIntroViewController") as! HUDIntroViewController
            self.addChildViewController(self.hudIntroVC)
            for subview in self.hudIntroVC.view.subviews {
                subview.isUserInteractionEnabled = true
                self.view.addSubview(subview)
            }
            self.hudIntroVC.didMove(toParentViewController: self)
        default:
            return
        }
        
    }
    
    func initCollect() {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { (timer) in
            self.hudCollectVC = self.storyboard?.instantiateViewController(withIdentifier: "HUDCollectViewController") as! HUDCollectViewController
            self.addChildViewController(self.hudCollectVC)
            for subview in self.hudCollectVC.view.subviews {
                subview.isUserInteractionEnabled = true
                self.view.addSubview(subview)
            }
            self.hudCollectVC.didMove(toParentViewController: self)
            self.mapVC.loadCollect()
        }
    }
}



extension TransportController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            self.locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.mapVC.locationUpdated()
    }
}

