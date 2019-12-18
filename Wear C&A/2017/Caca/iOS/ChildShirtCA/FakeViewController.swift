//
//  FakeViewController.swift
//  ChildShirtCA
//
//  Created by jeanpaul on 12/10/17.
//  Copyright © 2017 HackathonCA. All rights reserved.
//

import UIKit
import AVFoundation
import Speech

class FakeViewController: UIViewController {

    @IBOutlet weak var listeningDecorator: UIView!
    var audioPlayer = AVAudioPlayer()
    private let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "pt_BR"))
    private var recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
    private var recognitionTask: SFSpeechRecognitionTask?
    private let audioEngine = AVAudioEngine()
    private var query: String?
    private var isListening = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        NotificationCenter.default.addObserver(self, selector: #selector(volumeChanged(notification:)), name: NSNotification.Name(rawValue: "AVSystemController_SystemVolumeDidChangeNotification"), object: nil)
        self.speechRecognizer?.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.setupFake()
    }
    
    @IBAction func cleanFake(_ sender: UIButton) {
        self.isListening = false
    }
    
    @IBAction func listenPressed(_ sender: UIButton) {
        self.setupFake()
    }
    
    func setupFake() {
        if !self.isListening {
           self.listeningDecorator.isHidden = false
            self.recordAndRecognizeSpeech()
            self.isListening = true
            Timer.scheduledTimer(withTimeInterval: 3, repeats: false, block: { (timer) in
                timer.invalidate()
                self.sendQuestion(value: self.query!)
            })
        }
    }
//    func volumeChanged(notification: NSNotification) {
//
//    }
    
    func recordAndRecognizeSpeech() {
        guard let node = audioEngine.inputNode else { return }
        let recordingFormat = node.outputFormat(forBus: 0)
        node.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { buffer, _ in
            self.recognitionRequest.append(buffer)
        }
        audioEngine.prepare()
        do {
            try audioEngine.start()
        } catch {
            return print(error)
        }
        guard let myRecognizer = SFSpeechRecognizer() else {
            return
        }
        if !myRecognizer.isAvailable {
            // Recognizer is not available right now
            return
        }
        self.recognitionTask = self.speechRecognizer?.recognitionTask(with: self.recognitionRequest, resultHandler: { result, error in
            if let result = result {
                
                let bestString = result.bestTranscription.formattedString

                var lastString: String = ""
                for segment in result.bestTranscription.segments {
                    let indexTo = bestString.index(bestString.startIndex, offsetBy: segment.substringRange.location)
                    lastString = bestString.substring(from: indexTo)
                }
                self.query = bestString
            } else if let error = error {
                print(error)
            }
        })
    }
    
    func stopListening() {
        audioEngine.stop()
        audioEngine.inputNode?.removeTap(onBus: 0)
        recognitionTask = nil
    }
    
    func cancelRecording() {
        self.audioEngine.stop()
        if let node = audioEngine.inputNode {
            node.removeTap(onBus: 0)
        }
        self.recognitionTask?.cancel()
    }
    
    func sendQuestion(value: String) {
        self.cancelRecording()
        self.listeningDecorator.isHidden = true
        APIClient.sendQuestion(value: value) { (data) in
            do {
                self.audioPlayer = try AVAudioPlayer(data: data!)
                try AVAudioSession.sharedInstance().overrideOutputAudioPort(AVAudioSessionPortOverride.speaker)
                self.audioPlayer.prepareToPlay()
                self.audioPlayer.play()
            }
            catch {
            }
        }
    }
}



extension FakeViewController: SFSpeechRecognizerDelegate {
    
}
