//
//  ViewController.swift
//  HackthonGlobo
//
//  Created by Bruno Faganello Neto on 13/05/17.
//  Copyright © 2017 Bruno Faganello Neto. All rights reserved.
//

import UIKit
import Social
import FacebookCore
import FacebookLogin

class ViewController: UIViewController {
    
    func uploadVideoOnFacebook() {
        let loginManager = LoginManager()
        loginManager.logIn([.publishActions], viewController: self) { (loginResult) in
            switch loginResult {
            case .failed(let error):
                print(error)
            case .cancelled:
                print("User cancelled login.")
            case .success(let grantedPermissions, let declinedPermissions, let accessToken):
                print("Logged in!")
                var pathURL: URL
                var videoData: Data
                let strUploadVideoURL = Bundle.main.path(forResource: "cena", ofType: "mov")
                
                let urlpath     = Bundle.main.path(forResource: "cena", ofType: "mov")
                let url         = URL.init(fileURLWithPath: urlpath!)
                
                
                pathURL = URL(string: strUploadVideoURL!)!
                
                videoData = try! Data(contentsOf: url)
                let strDesc = ""
                
                var videoObject = ["title": "application Name",
                                   "description": strDesc,
                                   url.absoluteString: videoData] as [String : Any]
                
                
                var uploadRequest = GraphRequest(graphPath: "me/videos", parameters: videoObject, accessToken: accessToken, httpMethod: GraphRequestHTTPMethod.POST, apiVersion: GraphAPIVersion.defaultVersion)
                
                uploadRequest.start({ (response, request) in
                    print(request)
                })
            }
        }
    }
}


