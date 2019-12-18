//
//  MockUser.swift
//  OnboardingXP
//
//  Created by Jean Paul Marinho on 20/07/19.
//  Copyright © 2019 aKANJ. All rights reserved.
//

import MessageKit


struct MockUser: SenderType, Equatable {
    var senderId: String
    var displayName: String
}
