//
//
// Copyright 2017 Kobe, Inc.
// All rights reserved.
//
// This file, its contents, concepts, methods, behavior, and operation
// (collectively the "Software") are protected by trade secret, patent,
// and copyright laws. The use of the Software is governed by a license
// agreement. Disclosure of the Software to third parties, in any form,
// in whole or in part, is expressly prohibited except as authorized by
// the license agreement.
//

import UIKit
import AVKit
import AVFoundation

class VideoView: UIView {
    
    var playerLayer: AVPlayerLayer?
    var player: AVPlayer?
    var isLoop: Bool = false
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    func configure(url: String) {
        if let filePath = Bundle.main.path(forResource: url, ofType: ".mp4") {
            player = AVPlayer(url: URL(fileURLWithPath: filePath))
            playerLayer = AVPlayerLayer(player: player)
            playerLayer?.frame = bounds
            playerLayer?.videoGravity = AVLayerVideoGravityResize
            if let playerLayer = self.playerLayer {
                layer.addSublayer(playerLayer)
            }
            NotificationCenter.default.addObserver(self, selector: #selector(reachTheEndOfTheVideo(_:)), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: self.player?.currentItem)
            alpha = 0
        }
    }
    
    func play() {
        alpha = 1
        player?.play()
    }
    
    func pause() {
        alpha = 0
        player?.pause()
    }
    
    func stop() {
        alpha = 0
        player?.pause()
        player?.seek(to: kCMTimeZero)
    }
    
    func reachTheEndOfTheVideo(_ notification: Notification) {
        if isLoop {
            player?.pause()
            player?.seek(to: kCMTimeZero)
            player?.play()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        autoresizingMask.insert(.flexibleHeight)
        autoresizingMask.insert(.flexibleWidth)
    }
}
