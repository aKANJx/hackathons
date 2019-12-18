//
//  OnboardingViewController.swift
//  FoodKids
//
//  Created by Jean Paul Marinho on 19/08/18.
//  Copyright © 2018 Expresso MovHack Expresso MovHack Expresso MovHack Expresso MovHack. All rights reserved.
//

import UIKit
import Lottie

class OnboardingViewController: UIViewController {

    @IBOutlet var containerView: UIView!
    @IBOutlet var title1: UILabel!
    @IBOutlet var title2: UILabel!
    @IBOutlet var startButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title1.alpha = 0
        self.title2.alpha = 0
        self.startButton.alpha = 0
        let animationView = LOTAnimationView(name: "watermelon")
        animationView.frame = self.containerView.bounds
        self.containerView.addSubview(animationView)
        animationView.play{ (finished) in
        }
        UIView.animate(withDuration: 0.5, delay: 2, options: .curveEaseInOut, animations: {
            self.title1.alpha = 1
            self.title2.alpha = 1
        }, completion: { (success) in
            UIView.animate(withDuration: 0, delay: 1, options: .curveEaseInOut, animations: {
                self.startButton.alpha = 1
                self.title2.alpha = 1
            }, completion: nil)
        })
    }
}
