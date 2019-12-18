//
//  APIClient.swift
//  Share-Water
//
//  Created by Jean Paul Marinho on 14/02/17.
//  Copyright © 2017 aKANJ. All rights reserved.
//

import Foundation
import CoreLocation

class APIClient {
    class func deliveryLocation(_ completion: @escaping(_ coordinate: CLLocationCoordinate2D, _ error: Error?) -> ()) {
        completion(CLLocationCoordinate2DMake(-23.5189591, -46.4886198), nil)
    }
}
