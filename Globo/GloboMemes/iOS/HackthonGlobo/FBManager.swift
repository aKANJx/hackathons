//
//  FBManager.swift
//  HackthonGlobo
//
//  Created by Bruno Faganello Neto on 14/05/17.
//  Copyright © 2017 Bruno Faganello Neto. All rights reserved.
//

import UIKit
import FacebookLogin
import FacebookCore
import FacebookShare
class FBManager{
    func uploadVideoOnFacebook(view:UIViewController, urlVideo:URL) {
                let loginManager = LoginManager()
                    loginManager.logIn([.publishActions], viewController: view) { (loginResult) in
                            switch loginResult {
                                case .failed(let error):
                                        print(error)
                                case .cancelled:
                                        print("User cancelled login.")
                                case .success(let grantedPermissions, let declinedPermissions, let accessToken):
                                        print("Logged in!")
                                        var pathURL: URL
                                        var videoData: Data
                                        let strUploadVideoURL = Bundle.main.path(forResource: "cena", ofType: "mp4")
                        
                                        let urlpath     = Bundle.main.path(forResource: "cena", ofType: "mp4")
                                        let url         = URL.init(fileURLWithPath: urlpath!)
                        
                        
                                        pathURL = URL(string: strUploadVideoURL!)!
                        
                                        videoData = try! Data(contentsOf: urlVideo)
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

