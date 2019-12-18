//
//  ViewController.swift
//  ChildShirtCA
//
//  Created by jeanpaul on 12/9/17.
//  Copyright © 2017 HackathonCA. All rights reserved.
//

import UIKit
import AVFoundation

class MainViewController: UIViewController {
    
    var audioPlayer = AVAudioPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.sendText()
    }
        
    func sendText() {
        APIClient.sendQuestion(value: "Várias bolhas no seu mac  ") { (data) in
            do {
                self.audioPlayer = try AVAudioPlayer(data: data!)
                self.audioPlayer.prepareToPlay()
                self.audioPlayer.play()
            }
            catch {
                print("Failed")
            }
        }
    }
}
