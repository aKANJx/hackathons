//
//  APIClient.swift
//  HackEMTU
//
//  Created by Jean Paul Marinho on 4/8/18.
//  Copyright © 2018 aKANJ. All rights reserved.
//

import Foundation
import Alamofire
import CodableAlamofire

private struct Repo: Decodable {
    let name: String
    let stars: Int
    let url: URL
    let randomDateCommit: Date
    private enum CodingKeys: String, CodingKey {
        case name
        case stars
        case url
        case randomDateCommit = "random_date_commit"
    }
}

class APIClient {
    
    static let domainURL = "https://hacka-emtu.herokuapp.com/"

    class func getRoutes(with address: String, completion: @escaping ([Route]) -> Void) {
        let url = URL(string: "\(APIClient.domainURL)routes")!
        let body: [String: String] = [
            "endereco" : address ]
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        Alamofire.request(url, method: .post, parameters: body, encoding: JSONEncoding.default).responseDecodableObject(keyPath: "data", decoder: decoder) { (response: DataResponse<[Route]>) in
            let repo = response.result.value
            completion(repo!)
        }
    }
    
    class func getHome(completion: @escaping (HomeResponse) -> Void) {
        let url = URL(string: "\(APIClient.domainURL)home")!
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        Alamofire.request(url).responseDecodableObject(keyPath: "data", decoder: decoder) { (response: DataResponse<HomeResponse>) in
            let repo = response.result.value
            completion(repo!)
        }
    }
}
