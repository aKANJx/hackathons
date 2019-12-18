//
//  MockSocket.swift
//  OnboardingXP
//
//  Created by Jean Paul Marinho on 20/07/19.
//  Copyright © 2019 aKANJ. All rights reserved.
//

import UIKit
import MessageKit

final class MockSocket {
    
    static var shared = MockSocket()
    
    private var timer: Timer?
    
    private var queuedMessage: MockMessage?
    
    private var onNewMessageCode: ((MockMessage) -> Void)?
    
    private var onTypingStatusCode: (() -> Void)?
    
    private var connectedUsers: [MockUser] = []
    public var initialIDMessage = 0
    
    private init() {}
    
    @discardableResult
    func connect(with senders: [MockUser], using initialIDMessage: Int) -> Self {
        disconnect()
        connectedUsers = senders
        self.initialIDMessage = initialIDMessage
        handleTimer()
        timer = Timer.scheduledTimer(timeInterval: 2.5, target: self, selector: #selector(handleTimer), userInfo: nil, repeats: true)
        return self
    }
    
    @discardableResult
    func disconnect() -> Self {
        timer?.invalidate()
        timer = nil
        onTypingStatusCode = nil
        onNewMessageCode = nil
        return self
    }
    
    @discardableResult
    func onNewMessage(code: @escaping (MockMessage) -> Void) -> Self {
        onNewMessageCode = code
        return self
    }
    
    @discardableResult
    func onTypingStatus(code: @escaping () -> Void) -> Self {
        onTypingStatusCode = code
        return self
    }
    
    @objc
    private func handleTimer() {
        if let message = queuedMessage {
            onNewMessageCode?(message)
            queuedMessage = nil
        } else {
            let sender = arc4random_uniform(1) % 2 == 0 ? connectedUsers.first! : connectedUsers.last!
            if initialIDMessage == 12 {
                let image = UIImage(named: "leonardo")
                queuedMessage = MockMessage(image: image!, user: sender, messageId: UUID().uuidString, date: Date())
            }
            else {
                SampleData.shared.getMessage(id: initialIDMessage, sender: sender) { (message) in
                    queuedMessage = message.first
                }
            }
            initialIDMessage += 1
            onTypingStatusCode?()
        }
    }
    
}
