//
//  BicycleViewController.swift
//  TechCycle
//
//  Created by Jean Paul Marinho on 23/09/17.
//  Copyright © 2017 aKANJ. All rights reserved.
//

import UIKit
import ARKit

class BicycleViewController: UIViewController {

    @IBOutlet var sceneView: ARSCNView!
    var node: SCNNode!
    let centerScreen = CGPoint(x: 100, y: 100)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.sceneView.debugOptions = ARSCNDebugOptions.showFeaturePoints
        self.sceneView.delegate = self
        let scene = SCNScene(named: "art.scnassets/Bicycle.scn")!
        self.sceneView.scene = scene
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal
        self.node = self.sceneView.scene.rootNode.childNode(withName: "Bicycle", recursively: false)
        self.node.isHidden = true
        self.sceneView.session.run(configuration, options: .resetTracking)
    }
    
    func startHitTest() {
        
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (timer) in
            let hitTest = self.sceneView.hitTest(self.centerScreen, types: .estimatedHorizontalPlane)
            if let hitResult = hitTest.first {
                let scnMatrix = SCNMatrix4(hitResult.worldTransform)
                let position = SCNVector3Make(scnMatrix.m41, scnMatrix.m42, scnMatrix.m43)
                self.updateNode(position: position)
                timer.invalidate()
            }
        }
    }
    
    func updateNode(position: SCNVector3) {
        self.node.position = position
        self.node.isHidden = false
    }

}



extension BicycleViewController: ARSCNViewDelegate {
    
    func session(_ session: ARSession, cameraDidChangeTrackingState camera: ARCamera) {
        switch camera.trackingState {
        case .normal:
            self.startHitTest()
        default:
            return
        }
    }
}
