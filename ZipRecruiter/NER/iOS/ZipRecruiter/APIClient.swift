//
//  APIClient.swift
//  ZipRecruiter
//
//  Created by Jean Paul Marinho on 06/05/17.
//  Copyright © 2017 aKANJ. All rights reserved.
//

import UIKit
import SwiftyJSON

class APIClient: NSObject {
    
    class func getRecruiters(completion: @escaping (_ recruiters: [Recruiter]?) -> ()) {
        var recruiters = [Recruiter]()
        do {
            if let file = Bundle.main.url(forResource: "Recruiters", withExtension: "json") {
                let data = try Data(contentsOf: file)
                let json = JSON(data: data)
                for item in json.arrayValue {
                    recruiters.append(Recruiter(json: item))
                }
            }
            completion(recruiters)
        }
        catch {}
    }
    
    class func sendRequest(completion: @escaping (_ error: NSError?) -> ()) {
        completion(nil)
    }
}
