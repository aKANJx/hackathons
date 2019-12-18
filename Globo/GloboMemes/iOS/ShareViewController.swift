//
//  ShareViewController.swift
//  HackthonGlobo
//
//  Created by Bruno Faganello Neto on 14/05/17.
//  Copyright © 2017 Bruno Faganello Neto. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit
import Photos

class ShareViewController: UIViewController {
    
    @IBOutlet weak var previewVideo: UIView!
    var player = AVPlayer()
    var videoURL:URL?
    @IBOutlet weak var shareButton: UIButton! {
        didSet {
            shareButton.layer.borderWidth = 1.0
            shareButton.layer.borderColor = UIColor.clear.cgColor
            shareButton.layer.cornerRadius = shareButton.frame.size.height/2.0
            shareButton.clipsToBounds = true
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let videoURL = videoURL {
            self.player = AVPlayer(url: videoURL)
            
            let layer = AVPlayerLayer(player: self.player)
            
            layer.frame = self.previewVideo.bounds
            layer.videoGravity = AVLayerVideoGravityResize
            
            self.previewVideo.layer.addSublayer(layer)
            
            self.player.play()
            
            NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: self.player.currentItem, queue: nil, using: { (_) in
                DispatchQueue.main.async {
                    self.player.seek(to: kCMTimeZero)
                    self.player.play()
                }
            })
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func share(_ sender: Any) {
        let x = FBManager()
        if let videoURL = videoURL {
            x.uploadVideoOnFacebook(view: self, urlVideo: videoURL)
        }
    }
    
    @IBAction func backHomePressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveVideo(_ sender: UIButton) {
        guard let videoURL = videoURL else {
            return
        }
        PHPhotoLibrary.shared().performChanges({
            PHAssetChangeRequest.creationRequestForAssetFromVideo(atFileURL: videoURL)
        }) { saved, error in
            if saved {
                let alertController = UIAlertController(title: "Seu video foi salvo com sucesso", message: nil, preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alertController.addAction(defaultAction)
                self.present(alertController, animated: true, completion: nil)
            }
        }
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
