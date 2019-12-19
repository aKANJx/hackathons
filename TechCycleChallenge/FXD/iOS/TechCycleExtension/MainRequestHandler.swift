//
//  MainRequestHandler.swift
//  TechCycleExtension
//
//  Created by Jean Paul Marinho on 23/09/17.
//  Copyright © 2017 aKANJ. All rights reserved.
//

import Intents

class MainRequestHandler:
NSObject, INRequestRideIntentHandling {
    
    func handle(intent: INRequestRideIntent,
                completion: @escaping (INRequestRideIntentResponse) -> Void) {
        let response = INRequestRideIntentResponse(
            code: .failureRequiringAppLaunchNoServiceInArea,
            userActivity: .none)
        completion(response)
    }
}
