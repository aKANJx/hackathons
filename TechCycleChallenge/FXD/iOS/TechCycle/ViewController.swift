//
//  ViewController.swift
//  TechCycle
//
//  Created by Jean Paul Marinho on 23/09/17.
//  Copyright © 2017 aKANJ. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import Speech

class ViewController: UIViewController {

    @IBOutlet var mapView: MKMapView!
    let locationManager = CLLocationManager()
    var firstTime = true
    private let speechRecognizer = SFSpeechRecognizer(locale: Locale.init(identifier: "pt_BR"))
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    private var recognitionTask: SFSpeechRecognitionTask?
    private let audioEngine = AVAudioEngine()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.locationManager.desiredAccuracy = 50
        self.locationManager.delegate = self
        self.locationManager.requestAlwaysAuthorization()
        SFSpeechRecognizer.requestAuthorization { (authStatus) in
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {

        APIClient.getRiders(for: self.mapView.userLocation.coordinate) { riders in
            print(riders)
            self.mapView.addAnnotations(riders)
        }
    }
    
    @IBAction func micPressed(_ sender: UIButton) {
        if audioEngine.isRunning {
            audioEngine.stop()
            recognitionRequest?.endAudio()
        } else {
            startRecording()
        }
    }
    
    func updateLocation() {
        
    }
    
    func startRecording() {
        
        if recognitionTask != nil {
            recognitionTask?.cancel()
            recognitionTask = nil
        }
        
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(AVAudioSessionCategoryRecord)
            try audioSession.setMode(AVAudioSessionModeMeasurement)
            try audioSession.setActive(true, with: .notifyOthersOnDeactivation)
        } catch {
            print("audioSession properties weren't set because of an error.")
        }
        
        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        
        let inputNode = audioEngine.inputNode
        recognitionRequest?.shouldReportPartialResults = true
        
        recognitionTask = speechRecognizer?.recognitionTask(with: recognitionRequest!, resultHandler: { (result, error) in
            
            var isFinal = false
            
            if result != nil {
                
                print(result?.bestTranscription.formattedString as Any)
                isFinal = (result?.isFinal)!
            }
            
            if error != nil || isFinal {
                self.audioEngine.stop()
                inputNode.removeTap(onBus: 0)
                
                self.recognitionRequest = nil
                self.recognitionTask = nil
            }
        })
        
        let recordingFormat = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer, when) in
            self.recognitionRequest?.append(buffer)
        }
        
        audioEngine.prepare()
        
        do {
            try audioEngine.start()
        } catch {
            print("audioEngine couldn't start because of an error.")
        }
        
        print("Say something, I'm listening!")
    }
}


extension ViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            manager.startUpdatingLocation()
        default:
            return
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if firstTime {
            self.mapView.setRegion(MKCoordinateRegionMakeWithDistance((locations.first?.coordinate)!, 800, 800), animated: false)
            firstTime = false
        }
    }
}



extension ViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard !(annotation is MKUserLocation) else { return nil }
        
        let annotationIdentifier = "pin"
        var annotationView: MKAnnotationView?
        if let dequeuedAnnotationView = mapView.dequeueReusableAnnotationView(withIdentifier: annotationIdentifier) {
            annotationView = dequeuedAnnotationView
            annotationView?.annotation = annotation
        }
        else {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: annotationIdentifier)
        }
        
        if let annotationView = annotationView {
            
            annotationView.canShowCallout = true
            annotationView.image = UIImage(named: "icon-cycling")
        }
        return annotationView
    }
}

