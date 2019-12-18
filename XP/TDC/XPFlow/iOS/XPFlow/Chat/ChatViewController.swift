//
//  XPChatViewController.swift
//  OnboardingXP
//
//  Created by Jean Paul Marinho on 20/07/19.
//  Copyright © 2019 aKANJ. All rights reserved.
//

import UIKit
import MessageKit
import MapKit
import InputBarAccessoryView

enum DialogMoment: Int {
    case initial = 0
    case afterDream = 3
    case afterScan = 9
}

class ChatViewController: MessagesViewController, MessagesDataSource {
    
    var messageList: [MockMessage] = []
    let scanVC = ScanViewController()
    var dialogMoment: DialogMoment = .initial
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        messagesCollectionView.backgroundColor = .clear
        view.backgroundColor = .backgroundColor
        configureMessageCollectionView()
        configureMessageInputBar()
        let logoXP = UIImageView(image: UIImage(named: "logoXP"))
        logoXP.contentMode = .scaleAspectFit
        logoXP.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        navigationItem.titleView = logoXP
        messagesCollectionView.contentInset = UIEdgeInsets(top: 30, left: 0, bottom: 0, right: 0)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        MockSocket.shared.connect(with: [SampleData.shared.xpAssistant, SampleData.shared.steven], using: dialogMoment.rawValue)
            .onNewMessage { [weak self] message in
                self?.insertMessage(message)
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        MockSocket.shared.disconnect()
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        scanSocialID()
    }
    
    func configureMessageCollectionView() {
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messageCellDelegate = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
        scrollsToBottomOnKeyboardBeginsEditing = true
        maintainPositionOnKeyboardFrameChanged = true
    }
    
    func configureMessageInputBar() {
        messageInputBar.delegate = self
        messageInputBar.inputTextView.tintColor = .userColor
        messageInputBar.sendButton.setTitleColor(.goldColor, for: .normal)
        messageInputBar.sendButton.setTitleColor(
            UIColor.userColor.withAlphaComponent(0.3),
            for: .highlighted
        )
    }
    
    func insertMessage(_ message: MockMessage) {
        messageList.append(message)
        messagesCollectionView.performBatchUpdates({
            messagesCollectionView.insertSections([messageList.count - 1])
            if messageList.count >= 2 {
                messagesCollectionView.reloadSections([messageList.count - 2])
            }
        }, completion: { [weak self] _ in
            if self?.isLastSectionVisible() == true {
                self?.messagesCollectionView.scrollToBottom(animated: true)
            }
        })
    }
    
    func isLastSectionVisible() -> Bool {
        
        guard !messageList.isEmpty else { return false }
        let lastIndexPath = IndexPath(item: 0, section: messageList.count - 1)
        return messagesCollectionView.indexPathsForVisibleItems.contains(lastIndexPath)
    }
    
    func currentSender() -> SenderType {
        return SampleData.shared.currentSender
    }
    
    func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
        return messageList.count
    }
    
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
        return messageList[indexPath.section]
    }
    
    func messageTopLabelAttributedText(for message: MessageType, at indexPath: IndexPath) -> NSAttributedString? {
        let name = message.sender.displayName
        return NSAttributedString(string: name, attributes: [NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .caption1)])
    }
    
    func scanSocialID() {
        scanVC.startRecognition(from: self) { (socialID) in
            let uniqueID = UUID().uuidString
            let date = Date()
            let message =
            """
            Confirme os seus dados:
            Nome: \(socialID.name)
            RG: \(socialID.rg)
            CPF: \(socialID.cpf)
            Filiation: \(socialID.filiationName)
            Idade: \(socialID.age)
            """
            let socialIDMessage = MockMessage(text: message, user: SampleData.shared.xpAssistant, messageId: uniqueID, date: date)
            self.insertMessage(socialIDMessage)
        }
    }

}


extension ChatViewController: MessageCellDelegate {
        
    func didTapMessage(in cell: MessageCollectionViewCell) {
        switch dialogMoment {
        case .initial:
            let imageVC = UIImagePickerController()
            imageVC.delegate = self as? UIImagePickerControllerDelegate & UINavigationControllerDelegate
            imageVC.sourceType = .camera
            present(imageVC, animated: true, completion: nil)
            dialogMoment = .afterDream
            break
        case .afterDream:
            scanSocialID()
            dialogMoment = .afterScan
            break
        case .afterScan:
            print("Test")
        }
        MockSocket.shared.disconnect()
    }
}

// MARK: - MessageLabelDelegate

extension ChatViewController: MessageLabelDelegate {
    
    func didSelectHashtag(_ hashtag: String) {
        print("Hashtag selected: \(hashtag)")
    }
}

// MARK: - MessageInputBarDelegate

extension ChatViewController: InputBarAccessoryViewDelegate {
    
    func inputBar(_ inputBar: InputBarAccessoryView, didPressSendButtonWith text: String) {
        
        // Here we can parse for which substrings were autocompleted
        let attributedText = messageInputBar.inputTextView.attributedText!
        let range = NSRange(location: 0, length: attributedText.length)
        attributedText.enumerateAttribute(.autocompleted, in: range, options: []) { (_, range, _) in
            
            let substring = attributedText.attributedSubstring(from: range)
            let context = substring.attribute(.autocompletedContext, at: 0, effectiveRange: nil)
            print("Autocompleted: `", substring, "` with context: ", context ?? [])
        }
        
        let components = inputBar.inputTextView.components
        messageInputBar.inputTextView.text = String()
        messageInputBar.invalidatePlugins()
        
        // Send button activity animation
        messageInputBar.sendButton.startAnimating()
        messageInputBar.inputTextView.placeholder = "Sending..."
        DispatchQueue.global(qos: .default).async {
            // fake send request task
            sleep(1)
            DispatchQueue.main.async { [weak self] in
                self?.messageInputBar.sendButton.stopAnimating()
                self?.messageInputBar.inputTextView.placeholder = "Aa"
                self?.insertMessages(components)
                self?.messagesCollectionView.scrollToBottom(animated: true)
            }
        }
    }
    
    private func insertImage(image: UIImage) {
        let user = SampleData.shared.currentSender
        let message = MockMessage(image: image, user: user, messageId: UUID().uuidString, date: Date())
        insertMessage(message)
    }
    
    private func insertMessages(_ data: [Any]) {
        for component in data {
            let user = SampleData.shared.currentSender
            if let str = component as? String {
                let message = MockMessage(text: str, user: user, messageId: UUID().uuidString, date: Date())
                insertMessage(message)
            } else if let img = component as? UIImage {
                let message = MockMessage(image: img, user: user, messageId: UUID().uuidString, date: Date())
                insertMessage(message)
            }
        }
    }
}



extension ChatViewController: MessagesDisplayDelegate {
    
    // MARK: - Text Messages
    
    func textColor(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> UIColor {
        return .black//isFromCurrentSender(message: message) ? .goldColor : .black
    }
    
    func detectorAttributes(for detector: DetectorType, and message: MessageType, at indexPath: IndexPath) -> [NSAttributedString.Key: Any] {
        switch detector {
        case .hashtag, .mention: return [.foregroundColor: UIColor.blue]
        default: return MessageLabel.defaultAttributes
        }
    }
    
    func enabledDetectors(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> [DetectorType] {
        return [.url, .address, .phoneNumber, .date, .transitInformation, .mention, .hashtag]
    }
    
    // MARK: - All Messages
    
    func backgroundColor(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> UIColor {
        return isFromCurrentSender(message: message) ? .userColor : .goldColor
    }
    
    func messageStyle(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageStyle {
        
        let tail: MessageStyle.TailCorner = isFromCurrentSender(message: message) ? .bottomRight : .bottomLeft
        return .bubbleTail(tail, .curved)
    }
    
    func configureAvatarView(_ avatarView: AvatarView, for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) {
        let avatar = SampleData.shared.getAvatarFor(sender: message.sender)
        avatarView.set(avatar: avatar)
    }
}

// MARK: - MessagesLayoutDelegate

extension ChatViewController: MessagesLayoutDelegate {
    
    func cellTopLabelHeight(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> CGFloat {
        return 18
    }
    
    func cellBottomLabelHeight(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> CGFloat {
        return 17
    }
    
    func messageTopLabelHeight(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> CGFloat {
        return 20
    }
    
    func messageBottomLabelHeight(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> CGFloat {
        return 16
    }
    
}



extension ChatViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        let image = info[.originalImage] as? UIImage
        insertImage(image: image!)
    }
}
