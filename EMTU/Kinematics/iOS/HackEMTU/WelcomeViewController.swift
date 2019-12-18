//
//  WelcomeViewController.swift
//  HackEMTU
//
//  Created by Jean Paul Marinho on 4/8/18.
//  Copyright © 2018 aKANJ. All rights reserved.
//

import UIKit
import Lottie

class WelcomeViewController: UIViewController {

    @IBOutlet weak var lottieContainerView: UIView!
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet var secondStageView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.logoImageView.alpha = 0.0
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let animationView = LOTAnimationView(name: "bicycle-bm")
        self.lottieContainerView.addSubview(animationView)
        animationView.frame = self.lottieContainerView.bounds
        animationView.animationSpeed = 1.5
        animationView.loopAnimation = true
        animationView.play()
        UIView.animate(withDuration: 0.2, delay: 1.0, options: .curveEaseIn, animations: {
            self.logoImageView.alpha = 1.0
        }, completion: { (success) in
            if success {
                UIView.animate(withDuration: 2.0, animations: {
                    self.goToSecondStage()
                })
            }
        })
    }
    
    @IBAction func continuePressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func goToSecondStage() {
        UIView.animate(withDuration: 1.0, delay: 10.0, options: .curveEaseInOut, animations: {
            self.lottieContainerView.frame.offsetBy(dx: 0, dy: self.lottieContainerView.frame.height)
        }, completion: { (success) in
            if success {
                self.view.addSubview(self.secondStageView)
                self.secondStageView.frame = CGRect(x: self.lottieContainerView.frame.origin.x, y: self.view.frame.height-self.secondStageView.frame.height, width: self.secondStageView.frame.width, height: self.secondStageView.frame.height)
                UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseInOut, animations: {
                    self.secondStageView.frame.offsetBy(dx: 0, dy: -self.secondStageView.frame.height)
                }, completion: nil)
            }
        })
    }
}
