//
//  APIClient.swift
//  Abramit
//
//  Created by Jean Paul Marinho on 15/11/17.
//  Copyright © 2017 aKANJ. All rights reserved.
//

import Foundation
import Alamofire

class APIClient {
    
    class func sendInterest() {
        let urlString = "https://hacka-wework.herokuapp.com/add_interest"
        
        Alamofire.request(urlString, method: .post, parameters: ["nome":"Jean", "idImovel":1],encoding: JSONEncoding.default, headers: nil).responseJSON {
            response in
            return
        }
    }
    
    class func getEstates(completion: (_ estates: [Estate]) -> Void) {
        let url = Bundle.main.url(forResource: "Estates", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        let decoder = JSONDecoder()
        let estates = try! decoder.decode([Estate].self, from: data)
        completion(estates)
    }

}
