//
//  ChatViewController.swift
//  PiggyBank
//
//  Created by Jean Paul Marinho on 10/12/16.
//  Copyright © 2016 aKANJ. All rights reserved.
//

import UIKit
import JSQMessagesViewController

class ChatViewController: JSQMessagesViewController {

    var messages = [JSQMessage]()
    lazy var outgoingBubbleImageView: JSQMessagesBubbleImage = self.setupOutgoingBubble()
    lazy var incomingBubbleImageView: JSQMessagesBubbleImage = self.setupIncomingBubble()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.senderId = "123"
        self.senderDisplayName = "PiggyBank"
        collectionView!.collectionViewLayout.incomingAvatarViewSize = CGSize.zero
        collectionView!.collectionViewLayout.outgoingAvatarViewSize = CGSize.zero
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.addMessage(withId: "foo", name: "Santander", text: "Arredondamos o valor de cada transação realizada com seu cartão de maneira que você investe centavos por transação. Vamos começar? Envie: Sim ou Não")
    }
    
    func addMessage(withId id: String, name: String, text: String) {
        if let message = JSQMessage(senderId: id, displayName: name, text: text) {
            messages.append(message)
            JSQSystemSoundPlayer.jsq_playMessageSentSound()
            finishSendingMessage()
        }
    }
}

extension ChatViewController {
    
    func setupOutgoingBubble() -> JSQMessagesBubbleImage {
        let bubbleImageFactory = JSQMessagesBubbleImageFactory()
        return bubbleImageFactory!.outgoingMessagesBubbleImage(with: UIColor.jsq_messageBubbleBlue())
    }
    
    func setupIncomingBubble() -> JSQMessagesBubbleImage {
        let bubbleImageFactory = JSQMessagesBubbleImageFactory()
        return bubbleImageFactory!.incomingMessagesBubbleImage(with: UIColor.jsq_messageBubbleLightGray())
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, avatarImageDataForItemAt indexPath: IndexPath!) -> JSQMessageAvatarImageDataSource! {
        return nil
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageDataForItemAt indexPath: IndexPath!) -> JSQMessageData! {
        return messages[indexPath.item]
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = super.collectionView(collectionView, cellForItemAt: indexPath) as! JSQMessagesCollectionViewCell
        let message = messages[indexPath.item]
        
        if message.senderId == senderId {
            cell.textView?.textColor = UIColor.white
        } else {
            cell.textView?.textColor = UIColor.black
        }
        return cell
    }
    
    override func didPressSend(_ button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: Date!) {
        self.addMessage(withId: senderId, name: senderDisplayName!, text: text!)
        self.showTypingIndicator = true
        Timer.scheduledTimer(withTimeInterval: 3, repeats: true) { timer in
            var optin = false
            if (text!.lowercased().contains("sim")) {
                self.addMessage(withId: "foo", name: "Santander", text: "Você deu um passo importante para a sua educação financeira! Baixe nosso app através do link: pigg.ly e acompanhe o seu cofrinho em tempo real.")
                optin = true
            }
            else {
                self.addMessage(withId: "foo", name: "Santander", text: "Você falou que não. Caso deseje conhecer mais sobre a Piggly, acesse: pigg.ly")
            }
            APIClient.smsAnswer(optin: optin) { (success) in
                print(success)
            }
            self.showTypingIndicator = false
            timer.invalidate()
        }
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageBubbleImageDataForItemAt indexPath: IndexPath!) -> JSQMessageBubbleImageDataSource! {
        let message = messages[indexPath.item] // 1
        if message.senderId == senderId { // 2
            return outgoingBubbleImageView
        } else { // 3
            return incomingBubbleImageView
        }
    }
}
