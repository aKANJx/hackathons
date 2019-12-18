//
//  APIClient.swift
//  PiggyBank
//
//  Created by Jean Paul Marinho on 11/12/16.
//  Copyright © 2016 aKANJ. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class APIClient {
    
    class func smsAnswer(optin: Bool, completion: @escaping (_ success: Bool) -> ()) {
        let params = ["cellphone":"5511912345678","enabled_card": optin] as [String : Any]
        Alamofire.request("https://389bbd29.ngrok.io/api/update-sms", method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseJSON { (response:DataResponse<Any>) in
            switch(response.result) {
            case .success(_):
                completion(true)
                break
            case .failure(_):
                break
            }
        }
    }
    
    class func purchaseHistory(user: String, completion: @escaping (_ success: Bool, _ investments: [Investment]?, _ totalValue: Double) -> ()) {
        Alamofire.request("https://389bbd29.ngrok.io/api/get-purchase-history?cellphone=\(user)").responseJSON { response in
            var investments = [Investment]()
            let jsonArray = JSON(response.result.value!)
            for json in jsonArray["purchase"].arrayValue {
                let investment = Investment()
                investment.purchasePrice = json["total_value"].doubleValue
                investment.sellerType = json["seller_id"].stringValue
                investment.value = json["investiment_value"].doubleValue
                investments.append(investment)
            }
            let totalValue = jsonArray["total"].doubleValue
            completion(true,investments,totalValue)
        }
    }
}

