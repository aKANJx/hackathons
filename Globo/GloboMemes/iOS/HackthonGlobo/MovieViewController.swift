//
//  MovieViewController.swift
//  HackthonGlobo
//
//  Created by Jean Paul Marinho on 13/05/17.
//  Copyright © 2017 Bruno Faganello Neto. All rights reserved.
//

import UIKit
import GPUImage
import AVFoundation
import AVKit

class MovieViewController: UIViewController, UISplitViewControllerDelegate {
    
    @IBOutlet var filterSlider: UISlider?
    @IBOutlet var filterView: RenderView?
    @IBOutlet weak var closeButton: UIButton!
    
    var videoCamera:Camera?
    var blendImage:PictureInput?
    var movieInput: MovieInput?
    var timeline = [[String:Any]]()
    var movieTimer: Timer?
    var isRecording = false
    var movieOutput:MovieOutput? = nil
    var audioPlayer = AVAudioPlayer()
    var fileURL: URL?

    var resource: Resource?
    
    required init(coder aDecoder: NSCoder)
    {
        let path = Bundle.main.path(forResource: "Timeline", ofType: "plist")
        self.timeline = NSArray(contentsOfFile: path!) as! [[String:Any]]
        do {
            videoCamera = try Camera(sessionPreset:AVCaptureSessionPreset1920x1080, location:.backFacing)
            videoCamera!.runBenchmark = true
        } catch {
            videoCamera = nil
            print("Couldn't initialize camera with error: \(error)")
        }
        
        super.init(coder: aDecoder)!
    }
    
    var filterOperation: FilterOperationInterface?
    
    func configureView() {
        guard let videoCamera = videoCamera else {
            let errorAlertController = UIAlertController(title: NSLocalizedString("Error", comment: "Error"), message: "Couldn't initialize camera", preferredStyle: .alert)
            errorAlertController.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "OK"), style: .default, handler: nil))
            self.present(errorAlertController, animated: true, completion: nil)
            return
        }
        if let currentFilterConfiguration = self.filterOperation {
            self.title = currentFilterConfiguration.titleName
            
            // Configure the filter chain, ending with the view
            if let view = self.filterView {
                switch currentFilterConfiguration.filterOperationType {
                case .singleInput:
                    videoCamera.addTarget(currentFilterConfiguration.filter)
                    currentFilterConfiguration.filter.addTarget(view)
                case .blend:
                    videoCamera.addTarget(currentFilterConfiguration.filter)
                    
                    let filePath = Bundle.main.path(forResource: resource?.videoUrl, ofType: ".mp4")!
                    let filePathURL = NSURL.fileURL(withPath: filePath)
                    do {
                        self.movieInput = try MovieInput(url:filePathURL, playAtActualSpeed:true)
                        self.movieInput?.start()
                        let duration = AVURLAsset(url: filePathURL, options: nil).duration.seconds
                        Timer.scheduledTimer(withTimeInterval: duration, repeats: false, block: { (timer) in
                            self.recordVideo()
                            self.performSegue(withIdentifier: "ShareVC", sender: nil)
                        })
                        //DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            self.audioPlayer.play()
                        //}
                    }
                    catch {
                        print(error)
                    }
                    self.movieInput?.addTarget(currentFilterConfiguration.filter)
                    currentFilterConfiguration.filter.addTarget(view)
                case let .custom(filterSetupFunction:setupFunction):
                    currentFilterConfiguration.configureCustomFilter(setupFunction(videoCamera, currentFilterConfiguration.filter, view))
                }
                self.filterView?.transform = CGAffineTransform(scaleX: 1.1, y: 1)
                videoCamera.startCapture()
            }
            
            // Hide or display the slider, based on whether the filter needs it
            if let slider = self.filterSlider {
                switch currentFilterConfiguration.sliderConfiguration {
                case .disabled:
                    slider.isHidden = true
                //                case let .Enabled(minimumValue, initialValue, maximumValue, filterSliderCallback):
                case let .enabled(minimumValue, maximumValue, initialValue):
                    slider.minimumValue = minimumValue
                    slider.maximumValue = maximumValue
                    slider.value = initialValue
                    slider.isHidden = false
                    self.updateSliderValue()
                }
            }
        }
    }
    
    @IBAction func updateSliderValue() {
        if let currentFilterConfiguration = self.filterOperation {
            switch (currentFilterConfiguration.sliderConfiguration) {
            case .enabled(_, _, _): currentFilterConfiguration.updateBasedOnSliderValue(Float(self.filterSlider!.value))
            case .disabled: break
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureAudio()
        self.loadCamera()
    }
    
    func loadCamera() {
        self.filterOperation = FilterOperation(
            filter:{ContrastAdjustment()},
            listName:"Contrast",
            titleName:"Contrast",
            sliderConfiguration:.enabled(minimumValue:0.0, maximumValue:4.0, initialValue:1.0),
            sliderUpdateCallback: {(filter, sliderValue) in
                filter.contrast = sliderValue
        },
            filterOperationType:.singleInput
        )
        self.configureView()
    }
    
    func configureAudio() {
        let alertSound = NSURL(fileURLWithPath: Bundle.main.path(forResource: resource?.videoUrl, ofType: ".mp4")!)
        
        var error:NSError?
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: alertSound as URL)
        }
        catch {
        }
        audioPlayer.enableRate = true
        audioPlayer.rate = 0.95

        audioPlayer.prepareToPlay()

    }
    
    @IBAction func startButtonPressed(_ sender: UIButton) {
        sender.isUserInteractionEnabled = false
        sender.alpha = 0.5
        startVideo()
    }
    
    @IBAction func hideButtonPressed(_ sender: Any) {
        self.hideOverlay()
    }
    
    @IBAction func showButtonPressed(_ sender: Any) {
        self.showOverlay()
    }
    
    func hideOverlay() {
        filterOperation?.updateBasedOnSliderValue(1.0)
    }

    func showOverlay() {
        filterOperation?.updateBasedOnSliderValue(0.4)
    }
    
    func startVideo() {
        self.filterOperation?.filter.removeAllTargets()
        self.videoCamera?.stopCapture()
        self.videoCamera?.removeAllTargets()
        self.filterOperation = FilterOperation(
            filter:{ChromaKeyBlend()},
            listName:"Chroma key blend (green)",
            titleName:"Chroma Key (Green)",
            sliderConfiguration:.enabled(minimumValue:0.0, maximumValue:1.0, initialValue:0.4),
            sliderUpdateCallback: {(filter, sliderValue) in
                filter.thresholdSensitivity = sliderValue
        },
            filterOperationType:.blend
        )
        self.configureView()
        recordVideo()
        let filePath = Bundle.main.path(forResource: resource?.videoUrl, ofType: ".mp4")!
        if filePath .contains("cena.mp4") {
            for item in self.timeline {
                Timer.scheduledTimer(withTimeInterval: TimeInterval(item["initial"]! as! Float), repeats: false, block: { (timer) in
                    self.showOverlay()
                    Timer.scheduledTimer(withTimeInterval: TimeInterval(Float(item["duration"]! as! String)!), repeats: false, block: { (timer) in
                        self.hideOverlay()
                    }
                    )
                }
            )
            }
        }
    }
    
    @IBAction func recordVideoPressed(_ sender: UIButton) {
        recordVideo()
    }
    
    @IBAction func closeViewController(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func recordVideo() {
        isRecording = !isRecording
        if (isRecording) {
            do {
                let documentsDir = try FileManager.default.url(for:.documentDirectory, in:.userDomainMask, appropriateFor:nil, create:true)
                if let filename = resource?.filename {
                    self.fileURL = URL(string:"\(filename)-finished.mp4", relativeTo:documentsDir)!
                    do {
                        try FileManager.default.removeItem(at:fileURL!)
                    } catch {
                    }
                    movieOutput = try MovieOutput(URL:fileURL!, size:Size(width:480, height:640), liveVideo:true)
                    videoCamera?.audioEncodingTarget = movieOutput
                    (self.filterOperation?.filter)! --> movieOutput!
                    movieOutput!.startRecording()
                }
            } catch {
                fatalError("Couldn't initialize movie, error: \(error)")
            }
        } else {
            movieOutput?.finishRecording{
                self.isRecording = false
                self.videoCamera?.audioEncodingTarget = nil
                self.movieOutput = nil
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        videoCamera?.stopCapture()
        videoCamera?.removeAllTargets()
        blendImage?.removeAllTargets()
        movieInput?.removeAllTargets()
        filterOperation?.filter.removeAllTargets()
        self.videoCamera?.audioEncodingTarget = nil
        self.movieOutput = nil
        videoCamera = nil
        blendImage = nil
        movieInput = nil
        filterOperation = nil
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShareVC" {
            if let destination = segue.destination as? ShareViewController {
                destination.videoURL = self.fileURL
            }
        }
    }
}


extension MovieViewController: CameraDelegate {
    func didCaptureBuffer(_ sampleBuffer: CMSampleBuffer) {
    }
}
