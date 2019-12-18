//
//  CarScanViewController.swift
//  Torq
//
//  Created by Jean Paul Marinho on 20/10/18.
//  Copyright © 2018 aKANJ. All rights reserved.
//

import UIKit
import CoreML
import Vision

class CarScanViewController: UIViewController {

    @IBOutlet var cognitiveCameraView: CognitiveCameraView!
    var result: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Escanear Carro"
        cognitiveCameraView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        cognitiveCameraView.beginSession()
    }
    
    @IBAction func tappedScreen(_ sender: Any) {
        cognitiveCameraView.stopSession()
        performSegue(withIdentifier: "toScanResultVC", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! CarScanResultViewController
        if let result = result {
            vc.result = result
        }
    }
}



extension CarScanViewController: CognitiveCameraViewDelegate {
    
    func gotResult(identifier: String) {
        result = identifier
    }
}
