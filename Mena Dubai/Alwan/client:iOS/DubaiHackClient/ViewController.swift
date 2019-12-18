//
//  ViewController.swift
//  DubaiHackClient
//
//  Created by Jean Paul Marinho on 21/04/18.
//  Copyright © 2018 aKANJ. All rights reserved.
//

import UIKit
import Lottie
import CoreLocation

class ViewController: UIViewController {

    @IBOutlet weak var proximityContainerView: UIView!
    let locationManager = CLLocationManager()
    let beaconRegion = CLBeaconRegion(proximityUUID: UUID(uuidString: "B9407F30-F5F8-466E-AFF9-25556B57FE6D")!,
                                      major: 37064,
                                      minor: 59439,
                                      identifier: "TotemBeacon")

    override func viewDidLoad() {
        super.viewDidLoad()
        self.locationManager.delegate = self
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.startRangingBeacons(in: beaconRegion)
        let animationView = LOTAnimationView(name: "phonological")
        animationView.frame = self.proximityContainerView.bounds
        self.proximityContainerView.addSubview(animationView)
        animationView.loopAnimation = true
        animationView.play()
    }
    
    func totemApproach() {
        self.performSegue(withIdentifier: "ToColorVC", sender: nil)
    }
    
    func totemDepart() {
        self.presentedViewController?.dismiss(animated: true, completion: nil)
    }
}



extension ViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
        if beacons.count > 0 {
            if beacons.first!.rssi > -50 {
                self.totemApproach()
            }
            else {
                self.totemDepart()
            }
        }
    }
}
