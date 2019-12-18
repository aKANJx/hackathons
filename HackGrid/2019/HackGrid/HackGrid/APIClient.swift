//
//  APIClient.swift
//  HackGrid
//
//  Created by Jean Paul Marinho on 15/09/19.
//  Copyright © 2019 aKANJ. All rights reserved.
//

import Foundation

class APIClient {
    
    static var shared = APIClient()
    static let baseURL = "https://hacka-gr1d-api.herokuapp.com"

    class func getPolicies() {
        let url = URL(string: "\(APIClient.baseURL)/get_all_policies")!
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("error: \(error)")
            } else {
                if let response = response as? HTTPURLResponse {
                    print("statusCode: \(response.statusCode)")
                }
                if let data = data, let dataString = String(data: data, encoding: .utf8) {
                    print("data: \(dataString)")
                }
            }
        }
        task.resume()
    }
}
