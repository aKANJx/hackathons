//
//  SampleData.swift
//  OnboardingXP
//
//  Created by Jean Paul Marinho on 20/07/19.
//  Copyright © 2019 aKANJ. All rights reserved.
//

import MessageKit
import CoreLocation
import AVFoundation

final internal class SampleData {

    static let shared = SampleData()
    let dialog = [
        "Olá, eu sou o assistente virtual da XP! Fico muito feliz que você esteja conosco.",
        "Eu irei ajudá-lo em toda jornada no mundo de investimento 💪🏿",
        "Que tal me contar alguns sonhos que você tem ?! Ou se preferir, tire uma foto! Com isso poderei analisar melhor o seu perfil.",
        "Carrão hein 😱 ",
        "Me desculpa a pergunta, mas quanto você ganha por mes? 🤔",
        "Você levará 3.5 anos para alcançar o seu sonho se continuar investindo em modelos arcaicos de investimento (pou…cof cof…pança 🤮)",
        "Com a XP e nossos experts você levará somente 1.8 anos!!! 🤩",
        "Vou te ajudar a alcançar este objetivo e muitos outros! 😁",
        "Agora, você pode me falar o seu nome? Espera…tenho uma idéia melhor! Pode escanear o seu RG ou CNH para mim? Toque aqui para escaneá-lo.",
        "Um momento, estou analisando seus dados ….",
        "BEM VINDO AO CLUBE XP!!!",
        "",
        "Este é seu xpID - Login: 1123234, Senha: 2345433, TokenXP: 23424123",
        "Com ele você pode acessar as plataformas CLEAR, RYCO e claro nos da XP."
    ]
    
    private init() {}

    enum MessageTypes: String, CaseIterable {
        case Text
        case AttributedText
        case Photo
        case Video
        case Location
        case Url
        case Phone
        case Custom
    }

    let system = MockUser(senderId: "000000", displayName: "System")
    let xpAssistant = MockUser(senderId: "000001", displayName: "Assistente XP")
    let steven = MockUser(senderId: "000002", displayName: "Eu")

    lazy var senders = [steven, xpAssistant]

    var currentSender: MockUser {
        return steven
    }

    var now = Date()
    
    let messageImages: [UIImage] = [#imageLiteral(resourceName: "img1"), #imageLiteral(resourceName: "img2")]
    
    let attributes = ["Font1", "Font2", "Font3", "Font4", "Color", "Combo"]
    
    let locations: [CLLocation] = [
        CLLocation(latitude: 37.3118, longitude: -122.0312),
        CLLocation(latitude: 33.6318, longitude: -100.0386),
        CLLocation(latitude: 29.3358, longitude: -108.8311),
        CLLocation(latitude: 39.3218, longitude: -127.4312),
        CLLocation(latitude: 35.3218, longitude: -127.4314),
        CLLocation(latitude: 39.3218, longitude: -113.3317)
    ]

    func attributedString(with text: String) -> NSAttributedString {
        let nsString = NSString(string: text)
        var mutableAttributedString = NSMutableAttributedString(string: text)
        let randomAttribute = Int(arc4random_uniform(UInt32(attributes.count)))
        let range = NSRange(location: 0, length: nsString.length)
        
        switch attributes[randomAttribute] {
        case "Font1":
            mutableAttributedString.addAttribute(NSAttributedString.Key.font, value: UIFont.preferredFont(forTextStyle: .body), range: range)
        case "Font2":
            mutableAttributedString.addAttributes([NSAttributedString.Key.font: UIFont.monospacedDigitSystemFont(ofSize: UIFont.systemFontSize, weight: UIFont.Weight.bold)], range: range)
        case "Font3":
            mutableAttributedString.addAttributes([NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: UIFont.systemFontSize)], range: range)
        case "Font4":
            mutableAttributedString.addAttributes([NSAttributedString.Key.font: UIFont.italicSystemFont(ofSize: UIFont.systemFontSize)], range: range)
        case "Color":
            mutableAttributedString.addAttributes([NSAttributedString.Key.foregroundColor: UIColor.red], range: range)
        case "Combo":
            let msg9String = "Use .attributedText() to add bold, italic, colored text and more..."
            let msg9Text = NSString(string: msg9String)
            let msg9AttributedText = NSMutableAttributedString(string: String(msg9Text))
            
            msg9AttributedText.addAttribute(NSAttributedString.Key.font, value: UIFont.preferredFont(forTextStyle: .body), range: NSRange(location: 0, length: msg9Text.length))
            msg9AttributedText.addAttributes([NSAttributedString.Key.font: UIFont.monospacedDigitSystemFont(ofSize: UIFont.systemFontSize, weight: UIFont.Weight.bold)], range: msg9Text.range(of: ".attributedText()"))
            msg9AttributedText.addAttributes([NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: UIFont.systemFontSize)], range: msg9Text.range(of: "bold"))
            msg9AttributedText.addAttributes([NSAttributedString.Key.font: UIFont.italicSystemFont(ofSize: UIFont.systemFontSize)], range: msg9Text.range(of: "italic"))
            msg9AttributedText.addAttributes([NSAttributedString.Key.foregroundColor: UIColor.red], range: msg9Text.range(of: "colored"))
            mutableAttributedString = msg9AttributedText
        default:
            fatalError("Unrecognized attribute for mock message")
        }
        
        return NSAttributedString(attributedString: mutableAttributedString)
    }

    func dateAddingRandomTime() -> Date {
        let randomNumber = Int(arc4random_uniform(UInt32(10)))
        if randomNumber % 2 == 0 {
            let date = Calendar.current.date(byAdding: .hour, value: randomNumber, to: now)!
            now = date
            return date
        } else {
            let randomMinute = Int(arc4random_uniform(UInt32(59)))
            let date = Calendar.current.date(byAdding: .minute, value: randomMinute, to: now)!
            now = date
            return date
        }
    }
    
    func getMessage(id: Int, sender: MockUser, completion: ([MockMessage]) -> Void) {
        let uniqueID = UUID().uuidString
        let date = dateAddingRandomTime()
        var text = dialog[id]
        if text == "" {
            text = dialog[id+1]
        }
        let message = MockMessage(text: text, user: sender, messageId: uniqueID, date: date)
        completion([message])
    }

    func getAvatarFor(sender: SenderType) -> Avatar {
        let firstName = sender.displayName.components(separatedBy: " ").first
        let lastName = sender.displayName.components(separatedBy: " ").first
        let initials = "\(firstName?.first ?? "A")\(lastName?.first ?? "A")"
        switch sender.senderId {
        case "000001":
            return Avatar(image: #imageLiteral(resourceName: "Nathan-Tannar"), initials: initials)
        case "000002":
            return Avatar(image: #imageLiteral(resourceName: "Steven-Deutsch"), initials: initials)
        case "000003":
            return Avatar(image: #imageLiteral(resourceName: "Wu-Zhong"), initials: initials)
        case "000000":
            return Avatar(image: nil, initials: "SS")
        default:
            return Avatar(image: nil, initials: initials)
        }
    }

}
