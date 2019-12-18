//
//  BroadcastViewController.swift
//  JKIguatemi
//
//  Created by Jean Paul Marinho on 22/09/18.
//  Copyright © 2018 aKANJ. All rights reserved.
//

import UIKit
import Lottie
import CoreML

class BroadcastViewController: UIViewController {

    @IBOutlet var loadingContainerView: UIView!
    var images = [UIImage]()
    var imagesURL = [URL]()
    var influencerName: String!
    var request = [AlgorithmiaResponse]()
    var index = 0
    var gender: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        let animationView = LOTAnimationView(name: "loading")
        animationView.frame = loadingContainerView.bounds
        loadingContainerView.addSubview(animationView)
        animationView.loopAnimation = true
        animationView.contentMode = .scaleAspectFit
        animationView.play{ (finished) in
        }
        Timer.scheduledTimer(withTimeInterval: 20, repeats: false) { (timer) in
            timer.invalidate()
            self.performSegue(withIdentifier: "toSelectionVC", sender: nil)

//            DispatchQueue.main.async {
//
//                let model = GenderNet()
//                var analyzeImage = self.images.first!
//                analyzeImage = analyzeImage.cropped(boundingBox: CGRect(x: analyzeImage.size.width/2.0, y: 20, width: 227, height: 227))!
//                let prediction = try! model.prediction(data: ImageProcessor.pixelBuffer(forImage: analyzeImage.cgImage!)!)
//                let output = prediction.classLabel
//                self.gender = output
//            }
           
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! SelectionViewController
        vc.isFemale = true
//        if gender! == "Female" {
//            vc.isFemale = true
//        }
//        else {
//            vc.isFemale = false        }
    }
    
    func postData() {
        APIClient.sendML(name: influencerName, mlData: request)
        
    }
}



extension BroadcastViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imagesURL.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let imageURL = imagesURL[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! BroadcastCell
        cell.delegate = self
        cell.imageURL = imageURL
        return cell
    }
}



extension BroadcastViewController: BroadcastCellDelegate {
    
    func mlFinished(with wears: [Wear]) {
        let algo = AlgorithmiaResponse(imageURL: imagesURL[index].absoluteString, articles: wears)
        request.append(algo!)
        index += 1
        if index == imagesURL.count {
            postData()
        }
    }
}

