//
//  StationDetailViewController.swift
//  DubaiHackBO
//
//  Created by Jean Paul Marinho on 21/04/18.
//  Copyright © 2018 aKANJ. All rights reserved.
//

import UIKit
import MapKit

class StationDetailViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    var station: Station!
    @IBOutlet weak var dashboardView: UIView!
    @IBOutlet weak var deselectedLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = self.station.name
        self.dashboardView.frame = CGRect(x: 34, y: 1050, width: 1298, height: 370)
    }
    
    @IBAction func totem1Selected(_ sender: UIButton) {
        self.deselectedLabel.isHidden = true
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: {
            self.dashboardView.frame = CGRect(x: 34, y: 654, width: 1298, height: 370)
        }, completion: nil)
    }
}
