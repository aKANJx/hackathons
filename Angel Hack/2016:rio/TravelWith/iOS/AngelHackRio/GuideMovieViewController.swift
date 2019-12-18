//
//  GuideMovieViewController.swift
//  AngelHackRio
//
//  Created by Jean Paul Marinho on 26/06/16.
//  Copyright © 2016 Jean Paul Marinho. All rights reserved.
//

import UIKit
import AVFoundation

class GuideMovieViewController: UIViewController {

    var playerItem: AVPlayerItem?
    @IBOutlet weak var movieView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.startMovie()
    }
    
    func startMovie() {
        let path = Bundle.main().pathForResource("GuideVideo", ofType: "mp4")
        let url = NSURL.fileURL(withPath: path!)
        let asset = AVAsset(url: url)
        self.playerItem = AVPlayerItem(asset: asset)
        let player = AVPlayer(playerItem: playerItem!)
        let playerLayer : AVPlayerLayer? = AVPlayerLayer(player: player)
        playerLayer!.frame = self.movieView.frame
        //self.stepsView.layer.addSublayer(playerLayer!)
        //self.slider.maximumValue = Float(CMTimeGetSeconds(asset.duration))
//        player.addPeriodicTimeObserverForInterval(CMTimeMake(1, 100), queue: dispatch_get_main_queue()) {
//            [unowned self] time in
//            let _ = String(format: "%02.2f", CMTimeGetSeconds(time))
//            self.slider.value = Float(CMTimeGetSeconds(time))
//        }
        player.play()
    }
}
