//
//  CarDashViewController.swift
//  Torq
//
//  Created by Jean Paul Marinho on 21/10/18.
//  Copyright © 2018 aKANJ. All rights reserved.
//

import UIKit
import ARKit

class CarDashViewController: UIViewController {

    @IBOutlet var sceneView: ARSCNView!
    lazy var carDashLightsNode: SCNNode = {
        guard let scene = SCNScene(named: "CarDashLights.scn"),
            let node = scene.rootNode.childNode(withName: "main", recursively: false) else { return SCNNode() }
        let scaleFactor  = 0.25
        node.scale = SCNVector3(scaleFactor, scaleFactor, scaleFactor)
        node.eulerAngles.x += -.pi / 2
        return node
    }()
    lazy var fadeInOut: SCNAction = {
        return .sequence([
            .fadeIn(duration: 0.5),
            .wait(duration: 5),
            .fadeOut(duration: 0.5)
            ])
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sceneView.delegate = self
        configureLighting()
    }
    
    @IBAction func closePressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    func configureLighting() {
        sceneView.autoenablesDefaultLighting = true
        sceneView.automaticallyUpdatesLighting = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        resetTrackingConfiguration()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sceneView.session.pause()
    }
    
    func resetTrackingConfiguration() {
        guard let referenceImages = ARReferenceImage.referenceImages(inGroupNamed: "AR Resources", bundle: nil) else { return }
        let configuration = ARWorldTrackingConfiguration()
        configuration.detectionImages = referenceImages
        let options: ARSession.RunOptions = [.resetTracking, .removeExistingAnchors]
        sceneView.session.run(configuration, options: options)
    }
}




extension CarDashViewController: ARSCNViewDelegate {
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        DispatchQueue.main.async {
            guard let imageAnchor = anchor as? ARImageAnchor,
                let imageName = imageAnchor.referenceImage.name else { return }
            let overlayNode = self.carDashLightsNode
            overlayNode.childNodes.forEach({ (node) in
                node.isHidden = (node.name != imageName)
            })
            overlayNode.opacity = 0
            overlayNode.position.y = 0.2
            overlayNode.runAction(self.fadeInOut)
            node.addChildNode(overlayNode)
            print("Image detected: \"\(imageName)\"")
            Timer.scheduledTimer(withTimeInterval: 3, repeats: false, block: { (timer) in
                timer.invalidate()
                self.resetTrackingConfiguration()
            })
        }
    }
    
    func getPlaneNode(withReferenceImage image: ARReferenceImage) -> SCNNode {
        let plane = SCNPlane(width: image.physicalSize.width,
                             height: image.physicalSize.height)
        let node = SCNNode(geometry: plane)
        return node
    }
}
