//
//  ThingRouteViewController.swift
//  UberHack2019
//
//  Created by Jean Paul Marinho on 02/06/19.
//  Copyright © 2019 aKANJ. All rights reserved.
//

import UIKit

class ThingRouteViewController: UIViewController {

    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var distanceLabel: UILabel!

    
        func configure(time: Int, distance: Int) {
            timeLabel.text = "\(time) min"
            distanceLabel.text = "(\(distance) Km)"
        }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
