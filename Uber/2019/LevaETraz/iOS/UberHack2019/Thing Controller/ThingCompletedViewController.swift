//
//  ThingCompletedViewController.swift
//  UberHack2019
//
//  Created by Jean Paul Marinho on 02/06/19.
//  Copyright © 2019 aKANJ. All rights reserved.
//

import UIKit
import Lottie


class ThingCompletedViewController: UIViewController {

    @IBOutlet var completeMovinContainer: UIView!
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let completeMovin = AnimationView(name: "complete")
        completeMovinContainer.addSubview(completeMovin)
        completeMovin.frame = completeMovinContainer.bounds
        completeMovin.play { (finished) in
        }
    }
}
