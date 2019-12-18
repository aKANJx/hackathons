//
//  APIClient.swift
//  ChildShirtCA
//
//  Created by jeanpaul on 12/9/17.
//  Copyright © 2017 HackathonCA. All rights reserved.
//

import Foundation
import Alamofire

class APIClient {
    
    class func sendQuestion(value: String, completion: @escaping ((Data?) -> Void)) {
        let parameters: Parameters = [
            "text": "\(value)",
        ]
        Alamofire.request("https://childshirt.mybluemix.net/sendQuestion", method: .post, parameters: parameters).responseData
            { response in
                if let data = response.result.value {
                    completion(data)
                }
        }
    }
}
