//
//  APIClient.swift
//  BoaliHack
//
//  Created by Jean Paul Marinho on 25/08/19.
//  Copyright © 2019 aKANJ. All rights reserved.
//

import Foundation

class APIClient {
    
    static var shared = APIClient()
    var items = [String]()
    static let baseURL = "http://boali.vapor.cloud"

    class func postOrder(using description: String) {
        let url = URL(string: "\(APIClient.baseURL)/order")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        var description = ""
        for item in APIClient.shared.items {
            description = "\(description)\n\(item)"
        }
        APIClient.shared.items.removeAll()
        let body = ["description": description]
        request.httpBody = try? JSONEncoder().encode(body)
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
