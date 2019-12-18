//
//  LoginViewController.swift
//  PiggyBank
//
//  Created by Jean Paul Marinho on 11/12/16.
//  Copyright © 2016 aKANJ. All rights reserved.
//

import UIKit
import AVFoundation

class LoginViewController: UIViewController {

    var moviePlayer: AVPlayer!
    @IBOutlet weak var controls: UIView!
    @IBOutlet weak var logoImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.controls.alpha = 0
        self.logoImageView.alpha = 0
        let videoURL: NSURL = Bundle.main.url(forResource: "LoginMovie", withExtension: "mp4")! as NSURL
        self.moviePlayer = AVPlayer(url: videoURL as URL)
        self.moviePlayer.isMuted = true
        let playerLayer = AVPlayerLayer(player: self.moviePlayer)
        playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
        playerLayer.zPosition = -1
        playerLayer.frame = CGRect(x: self.view.frame.origin.x, y: -5, width: self.view.frame.size.width, height: self.view.frame.size.height + 10)
        self.view.layer.addSublayer(playerLayer)
        self.moviePlayer.play()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animate(withDuration: 0.5, delay: 3, options: .curveEaseInOut, animations: {
            self.controls.alpha = 1
            self.logoImageView.alpha = 1
        }, completion: nil)
    }
    
    @IBAction func askMeLaterPressed(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "RootNavigationController")
        UIApplication.shared.keyWindow?.rootViewController = vc
    }
}
