//
//  IntentHandler.swift
//  TechCycleExtension
//
//  Created by Jean Paul Marinho on 23/09/17.
//  Copyright © 2017 aKANJ. All rights reserved.
//

import Intents

class IntentHandler: INExtension {
    
    override func handler(for intent: INIntent) -> Any? {
        if intent is INRequestRideIntent {
            return MainRequestHandler()
        }
        return .none
    }
}
