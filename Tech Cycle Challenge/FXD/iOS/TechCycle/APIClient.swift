//
//  APIClient.swift
//  TechCycle
//
//  Created by Jean Paul Marinho on 23/09/17.
//  Copyright © 2017 aKANJ. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire
import AlamofireSwiftyJSON

struct APIClient {
    
    static func getRiders(for coordinate: CLLocationCoordinate2D, completion: @escaping ([Rider]) -> Void) {
        var riders = [Rider]()
        let url = "http://192.168.43.89/workspace/fxd/happnfxd.php"
        Alamofire.request(url).responseSwiftyJSON { response in
            if let json = response.result.value {
                for (_,subJson) in json {
                    let latitude = subJson["lat"].string!
                    let longitude = subJson["lng"].string!
                    let rider = Rider(coordinate: CLLocationCoordinate2D(latitude: Double(latitude)!, longitude: Double(longitude)!))
                    rider.title = subJson["name"].string!
                    riders.append(rider)
                }
            }
            completion(riders)
        }
    }
    
    static func sendOccurrence(in coordinate: CLLocationCoordinate2D, completion: @escaping ([Rider]) -> Void) {
        let url = "http://192.168.43.89/workspace/fxd/insertoccurrence.php"
        let params = ["lat":"\(coordinate.latitude)","lng":"\(coordinate.longitude)","type":"Buraco"]
        Alamofire.request(url, method: .post, parameters: params).responseSwiftyJSON { response in
        }
    }
}
