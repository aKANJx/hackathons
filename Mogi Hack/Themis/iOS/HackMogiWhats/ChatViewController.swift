//
//  ChatViewController.swift
//  HackMogiWhats
//
//  Created by jeanpaul on 2/2/19.
//  Copyright © 2019 Jean Paul Marinho. All rights reserved.
//

import UIKit
import AVFoundation

class ChatViewController: UIViewController {

    var player: AVPlayer?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playBackgoundVideo()
    }
    
    @IBAction func playPressed(_ sender: UIButton) {
        player?.play()

    }
    
    @IBAction func mapPressed(_ sender: UIButton) {
        goToMap()
    }
    
    private func playBackgoundVideo() {
        if let filePath = Bundle.main.path(forResource: "chat", ofType:"mp4") {
            let filePathUrl = NSURL.fileURL(withPath: filePath)
            player = AVPlayer(url: filePathUrl)
            let playerLayer = AVPlayerLayer(player: player)
            playerLayer.frame = view.bounds
            playerLayer.videoGravity = .resizeAspectFill
//            NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: self.player?.currentItem, queue: nil) { (_) in
//                self.player?.seek(to: .zero)
//                self.player?.play()
//            }
            view.layer.addSublayer(playerLayer)
        }
    }
    
    func goToMap() {
        performSegue(withIdentifier: "goToMap", sender: nil)
    }
}
