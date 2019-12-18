//
//  RequestService.swift
//  Saiga
//
//  Created by Bruno Faganello Neto on 25/08/18.
//  Copyright © 2018 Faganello. All rights reserved.
//

import UIKit
import Alamofire


class RequestService: NSObject {
    static private let baseURL:String = "https://saiga.vapor.cloud/"

    
    class func getUser(completionHandler:@escaping (_ user:User)-> ()){
        let fullUrl = self.baseURL + "login"
        let url = URL(string: fullUrl)!
        Alamofire.request(url,method: .post,
                          parameters: nil,
                          encoding: URLEncoding.default,
                          headers: nil)
            .responseData { response in
                guard response.error == nil else {
                    print(response.error!)
                    return
                }
                
                guard let responseData = response.data else {
                    print("didn't get any data from API")
                    let error = ResponseDataError()
                    return
                }
                
                do {
                    let item = try JSONDecoder().decode(User.self, from: responseData)
                    completionHandler(item)
                } catch {
                    print("error trying to decode response")
                    print(error)
                    return
                }
        }
    }

}
