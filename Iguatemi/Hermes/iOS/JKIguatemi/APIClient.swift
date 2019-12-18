//
//  APIClient.swift
//  JKIguatemi
//
//  Created by Jean Paul Marinho on 23/09/18.
//  Copyright © 2018 aKANJ. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class APIClient {
    
    class func upload(image: UIImage, completion: @escaping (_ result: String) -> Void) {
        let imageData = image.jpegData(compressionQuality: 0.3)
        
        let urlString = "https://hacka-jk.herokuapp.com/upload"
        let session = URLSession(configuration: URLSessionConfiguration.default)
        
        let mutableURLRequest = NSMutableURLRequest(url: NSURL(string: urlString)! as URL)
        
        mutableURLRequest.httpMethod = "POST"
        
        let boundaryConstant = "----------------12345";
        let contentType = "multipart/form-data;boundary=" + boundaryConstant
        mutableURLRequest.setValue(contentType, forHTTPHeaderField: "Content-Type")
        // create upload data to send
        let uploadData = NSMutableData()
        // add image
        uploadData.append("\r\n--\(boundaryConstant)\r\n".data(using: String.Encoding.utf8)!)
        uploadData.append("Content-Disposition: form-data; name=\"picture\"; filename=\"file.png\"\r\n".data(using: String.Encoding.utf8)!)
        uploadData.append("Content-Type: image/jpg\r\n\r\n".data(using: String.Encoding.utf8)!)
        uploadData.append(imageData!)
        uploadData.append("\r\n--\(boundaryConstant)--\r\n".data(using: String.Encoding.utf8)!)
        mutableURLRequest.httpBody = uploadData as Data
        let task = session.dataTask(with: mutableURLRequest as URLRequest, completionHandler: { (data, response, error) -> Void in
            if error == nil {
                let responseString = "https://hacka-jk.herokuapp.com/get_image/\(String(data: data!, encoding: String.Encoding.utf8)!)"
                completion(responseString)                
            }
        })
        
        task.resume()
    }
    
    class func getInfluencerDetail(with name: String, completion:@escaping (Result<Influencer>)->Void) {
        AF.request("https://hacka-jk.herokuapp.com/images/\(name.replacingOccurrences(of: " ", with: ""))").responseJSONDecodable { (response: DataResponse<Influencer>) in
            completion(response.result)
        }
    }
    
    class func sendBroadcast(body: BroadcastBody) {
        
    }
    
    struct BroadcastBody: Codable {
        let influencer_name: String
        let items: [RequestBodyItem]
        
        struct RequestBodyItem: Codable {
            let imageID: String
            let ml_analysis: RequestBodyMLAnalysis
        }
        
        struct  RequestBodyMLAnalysis: Codable {
            let article_name: String
            let bounding_box: RequestBodyBoundingBox
        }
        
        struct RequestBodyBoundingBox: Codable {
            let x0: Int
            let x1: Int
            let y0: Int
            let y1: Int
        }
    }
    
    class func sendML(name: String, mlData: [AlgorithmiaResponse]) {
        let encoder = JSONEncoder()
        let headers = [
            "Content-Type": "application/x-www-form-urlencoded"
        ]
        let resultado_vr = try! encoder.encode(mlData)
        let mlBody = String(data: resultado_vr, encoding: .utf8)
        let params = ["texto_chave": name, "idCliente":1, "resultado_vr": mlBody!] as [String : Any]
        AF.request("https://hacka-jk.herokuapp.com/api/broadcast", method: .post, parameters: params, encoding: URLEncoding.default, headers: headers).responseString { (result) in
            print(result)
        }
    }
}
