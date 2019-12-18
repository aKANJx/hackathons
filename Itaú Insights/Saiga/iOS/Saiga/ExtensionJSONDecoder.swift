//
//  ExtensionJSONDecoder.swift
//  Saiga
//
//  Created by Bruno Faganello Neto on 25/08/18.
//  Copyright © 2018 Faganello. All rights reserved.
//

import UIKit
import Alamofire

struct ResponseDataError:Error{}


extension JSONDecoder {
    func decodeResponse<T:Decodable>(from response: DataResponse<T>) -> T? {
        
        guard response.error == nil else {
            print(response.error!)
            return nil
        }
        
        guard let responseData = response.data else {
            print("didn't get any data from API")
            let error = ResponseDataError()
            return nil
        }
        
        do {
            print(T.self)
            let item = try decode(T.self, from: responseData)
            return item
        } catch {
            print("error trying to decode response")
            print(error)
            return nil
        }
    }
}
