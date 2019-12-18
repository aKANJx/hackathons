//
//  APIClient.swift
//  BoaliPDV
//
//  Created by Jean Paul Marinho on 25/08/19.
//  Copyright © 2019 aKANJ. All rights reserved.
//

import Foundation

class APIClient {
    
    static let baseURL = "http://boali.vapor.cloud"

    static func getOrder(with completion: @escaping (([Order])->())) {
        let url = URL(string: "\(APIClient.baseURL)/order")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("error: \(error)")
            } else {
                if let response = response as? HTTPURLResponse {
                    print("statusCode: \(response.statusCode)")
                }
                if let data = data, let dataString = String(data: data, encoding: .utf8) {
                    let orders = try? JSONDecoder().decode([Order].self, from: data)
                    completion(orders ?? [])
                    print("data: \(dataString)")
                }
            }
        }
        task.resume()

        
    }
}
