//
//  DeliveryDetailViewController.swift
//  Share-Water
//
//  Created by Jean Paul Marinho on 15/02/17.
//  Copyright © 2017 aKANJ. All rights reserved.
//

import UIKit

class DeliveryDetailViewController: UIViewController {
    
    let fullStateY: CGFloat = 440
    let partialStateY: CGFloat = 0
    @IBOutlet weak var driverImageView: UIImageView!
    @IBOutlet weak var progressBarView: UIView!
    var timer: Timer!
    
    override func viewDidLoad() {
        self.driverImageView.layer.cornerRadius = self.driverImageView.frame.size.width / 2
        self.driverImageView.clipsToBounds = true
        self.driverImageView.layer.borderWidth = 1.5;
        self.driverImageView.layer.borderColor = UIColor.white.cgColor
        self.driverImageView.layer.cornerRadius = 30
    }
    
    override func viewDidAppear(_ animated: Bool) {
        UIView.animate(withDuration: 0.3) {
            let frameSize = self.view.frame.size
            let yComponent = UIScreen.main.bounds.height - 145
            self.view.frame = CGRect(x: 0, y: yComponent, width: frameSize.width, height: frameSize.height)
            let panGesture = UIPanGestureRecognizer(target: self, action: #selector(self.panGesture(_:)))
            self.view.addGestureRecognizer(panGesture)
            self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.updateProgressBar), userInfo: nil, repeats: true);
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.timer.invalidate()
    }
    
    func updateProgressBar() {
        var frame = self.progressBarView.frame
        frame.size.width = frame.size.width + 1
        self.progressBarView.frame = frame
        self.progressBarView.setNeedsDisplay()
    }
    
    func panGesture(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: self.view)
        let y = self.view.frame.minY
        let frameSize = self.view.frame.size
        let translatedY = y + translation.y
        print(y + translation.y)
        if (translatedY >= partialStateY) && (translatedY <= fullStateY) {
            self.view.frame = CGRect(x: 0, y: translatedY, width: frameSize.width, height: frameSize.height)
            sender.setTranslation(CGPoint.zero, in: self.view)
        }
        if sender.state == .ended {
            let velocity = sender.velocity(in: self.view)
            var duration =  velocity.y < 0 ? Double(15*(y - fullStateY) / -velocity.y) : Double(15*(partialStateY - y) / velocity.y )
            duration = duration > 1.3 ? 1 : duration
            UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: 0, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                if  velocity.y < 0 {
                    self.view.frame = CGRect(x: 0, y: self.partialStateY, width: frameSize.width, height: frameSize.height)
                    self.view.backgroundColor = UIColor(colorLiteralRed: 0, green: 0, blue: 0, alpha: 0.4)
                } else {
                    self.view.frame = CGRect(x: 0, y: self.fullStateY, width: frameSize.width, height: frameSize.height)
                    self.view.backgroundColor = UIColor.clear
                }
            }, completion: nil)
        }
    }
}
