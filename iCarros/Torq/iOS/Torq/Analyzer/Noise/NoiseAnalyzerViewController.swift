//
//  NoiseAnalyzerViewController.swift
//  Torq
//
//  Created by Jean Paul Marinho on 20/10/18.
//  Copyright © 2018 aKANJ. All rights reserved.
//

import UIKit
import SoundWave

class NoiseAnalyzerViewController: UIViewController {

    @IBOutlet var cameraView: CameraView!
    @IBOutlet var waveView: AudioVisualizationView!

    override func viewDidLoad() {
        super.viewDidLoad()
        cameraView.beginSession()
        waveView.audioVisualizationMode = .write
        waveView.meteringLevelBarWidth = 2
        waveView.meteringLevelBarInterItem = 1
        waveView.meteringLevelBarCornerRadius = 12
        waveView.gradientStartColor = UIColor.white
        waveView.gradientEndColor = UIColor.gray
        
        AudioRecorderManager.shared.askPermission { (success) in
            self.configureNoiseDetection()
            Timer.scheduledTimer(withTimeInterval: 1, repeats: false, block: { (timer) in
                self.startRecording()
            })
        }
    }
    
    @IBAction func dismissPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func startRecording() {
        AudioRecorderManager.shared.startRecording(with: 0.01, completion: { [weak self] url, error in
//            self?.currentAudioRecord = SoundRecord(audioFilePathLocal: url, meteringLevels: [])
//            print("sound record created at url \(url.absoluteString))")

        })
    }
    
    func configureNoiseDetection() {
        NotificationCenter.default.addObserver(self, selector: #selector(NoiseAnalyzerViewController.didReceiveMeteringLevelUpdate(_:)),
                                               name: .audioRecorderManagerMeteringLevelDidUpdateNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(NoiseAnalyzerViewController.didFinishRecordOrPlayAudio),
                                               name: .audioRecorderManagerMeteringLevelDidFinishNotification, object: nil)
    }
    
    @objc private func didReceiveMeteringLevelUpdate(_ notification: Notification) {
        let percentage = notification.userInfo![audioPercentageUserInfoKey] as! Float
        waveView.add(meteringLevel: percentage*5)
    }
    
    @objc private func didFinishRecordOrPlayAudio(_ notification: Notification) {
        self.waveView.stop()
    }
}
