//
//  ReducePriceViewController.swift
//  HackAmericas
//
//  Created by jeanpaul on 12/1/18.
//  Copyright © 2018 Jean Paul Marinho. All rights reserved.
//

import UIKit
import Lottie

class ReductorWelcomeViewController: UIViewController {

    @IBOutlet var lottieContainer: UIView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var subtitleLabel: UILabel!
    @IBOutlet var continueButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.alpha = 0
        subtitleLabel.alpha = 0
        continueButton.alpha = 0
        let animView = LOTAnimationView(name: "done")
        animView.loopAnimation = true
        animView.contentMode = .scaleAspectFit
        animView.frame = lottieContainer.bounds
        lottieContainer.addSubview(animView)
        animView.play()
        UIView.animate(withDuration: 1, delay: 2, options: .curveEaseInOut, animations: {
            self.titleLabel.alpha = 1
            self.subtitleLabel.alpha = 1
        }) { (success) in
            self.continueButton.alpha = 1
        }
    }
    
    @IBAction func closePressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
}
