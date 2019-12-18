//
//  APIClient.swift
//  Fiesp5th
//
//  Created by Jean Paul Marinho on 16/10/16.
//  Copyright © 2016 aKANJ. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

final class APIClient {
    
    
    class func ringData(completion: @escaping (JSON, Error?) -> ()) {
        let headers =
            ["Authorization":"Basic NjZmcm4wbDVvaGR1Okc1WmlFUGxuSFRKYQ=="
        ]
        Alamofire.request("http://api.hackathon.konkerlabs.net:80/sub/66frn0l5ohdu/enviar", headers: headers).responseJSON { (responseData) -> Void in
            if((responseData.result.value) != nil) {
                let json = JSON(responseData.result.value!)
                completion(json, nil)
            }
        }
    }
    
    class func payment(json: JSON, amount: Int, completion: @escaping (Bool, Error?) -> ()) {
        let results = json[0]["data"]
        var parameters = [String:Any]()
        parameters["id_wearable"] = results["id_wearable"].stringValue
        parameters["temperatura"] = results["temperatura"].stringValue
        parameters["token"] = results["token"].stringValue
        parameters["codigocliente"] = results["codigocliente"].stringValue
        parameters["valor"] = "\(amount)"
        parameters["id_credenciado"] = "X211435"
        Alamofire.request("http://189.55.194.115:3000/confirmarpagamento", method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .responseJSON { (responseData) -> Void in
                if((responseData.result.value) != nil) {
                    let success = JSON(responseData.result.value!)["pagamento"].boolValue
                    completion(success, nil)
                }
                else {
                    completion(false,nil)
                }
        }
    }
    
    class func receipt(completion: (Error?) -> ()) {
    }

}
