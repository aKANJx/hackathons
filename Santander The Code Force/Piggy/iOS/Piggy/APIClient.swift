//
//  APIClient.swift
//  Piggy
//
//  Created by Jean Paul Marinho on 12/01/17.
//  Copyright © 2017 aKANJ. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON
import KeychainSwift

class APIClient {
    
    class func sendLogin(cpf: String, password: String, completion: @escaping (_ error: Error?, _ newUser: Bool?) -> ()) {
        
        let keychain = KeychainSwift()
        keychain.set(cpf, forKey: "cpf")
        let params = ["cpf": cpf, "password": password]
        Alamofire.request("https://piggydigital.herokuapp.com/api/account/login", method: .post, parameters: params, encoding: JSONEncoding.default).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                guard json["success"].boolValue != false else {
                    completion(NSError(domain: json["message"].stringValue, code: 0, userInfo: nil), nil)
                    return
                }
                completion(nil, json["data"]["newUser"].boolValue)
            case .failure(let error):
                completion(error, nil)
            }
        }
    }
    
    class func createPersonalPiggy(alias: String, image: UIImage?, completion: @escaping (_ error: Error?) -> ()) {
        
        let keychain = KeychainSwift()
        let cpf = keychain.get("cpf")
        guard cpf != nil else {
            completion(NSError(domain: "", code: 0, userInfo: nil))
            return
        }
        let params = ["cpf": cpf!, "alias": alias] as [String:Any]
//        if let image = image  {
//            let imageData = UIImageJPEGRepresentation(image, 0.5)
//            let base64String = imageData?.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
//            params["image"] = base64String
//        }
        Alamofire.request("https://piggydigital.herokuapp.com/api/piggy/create-personal", method: .post, parameters: params, encoding: JSONEncoding.default).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                guard json["success"].boolValue != false else {
                    completion(NSError(domain: json["message"].stringValue, code: 0, userInfo: nil))
                    return
                }
                completion(nil)
            case .failure(let error):
                completion(error)
            }
        }
    }
    
    class func getPiggies(completion: @escaping (_ error: Error?, _ categories: [Category]?) -> ()) {
//        let activePiggy = Piggy(dictionary: ["type":0, "image":UIImage(named: "JeanPaulMarinhoPhoto")!, "title":"Jean Paul Marinho", "alias":"@aKANJ", "about":"Piggy Pessoal", "isPublic":true, "seeders":1, "savingsTier":0])
//        let myPiggy1 = Piggy(dictionary: ["type":1, "image":UIImage(named: "Event-placeholder1")!, "title":"Dev Festival", "alias":"@DevFestival", "about":"Prepare seu computador, sua mochila e reserve na agenda a semana de 25 a 31 de janeiro de 2017! A cidade de São Paulo receberá a terceira edição do maior evento de internet e redes do mundo.", "isPublic":true, "seeders":67, "savingsTier":2])
//        let myPiggy2 = Piggy(dictionary: ["type":1, "image":UIImage(named: "Event-placeholder1")!, "title":"Dev Festival", "alias":"@DevFestival", "about":"Prepare seu computador, sua mochila e reserve na agenda a semana de 25 a 31 de janeiro de 2017! A cidade de São Paulo receberá a terceira edição do maior evento de internet e redes do mundo.", "isPublic":true, "seeders":67, "savingsTier":2])
//        let myPiggy3 = Piggy(dictionary: ["type":1, "image":UIImage(named: "Event-placeholder1")!, "title":"Dev Festival", "alias":"@DevFestival", "about":"Prepare seu computador, sua mochila e reserve na agenda a semana de 25 a 31 de janeiro de 2017! A cidade de São Paulo receberá a terceira edição do maior evento de internet e redes do mundo.", "isPublic":true, "seeders":67, "savingsTier":2])
//        let myPiggy4 = Piggy(dictionary: ["type":0, "image":UIImage(named: "Event-placeholder1")!, "title":"Dev Festival", "alias":"@DevFestival", "about":"Prepare seu computador, sua mochila e reserve na agenda a semana de 25 a 31 de janeiro de 2017! A cidade de São Paulo receberá a terceira edição do maior evento de internet e redes do mundo.", "isPublic":true, "seeders":67, "savingsTier":2])
//        let myPiggy5 = Piggy(dictionary: ["type":1, "image":UIImage(named: "Event-placeholder1")!, "title":"Dev Festival", "alias":"@DevFestival", "about":"Prepare seu computador, sua mochila e reserve na agenda a semana de 25 a 31 de janeiro de 2017! A cidade de São Paulo receberá a terceira edição do maior evento de internet e redes do mundo.", "isPublic":true, "seeders":67, "savingsTier":2])
//
//        let category1 = Category(dictionary: ["title": "Piggy Ativo", "about": "", "piggies":[activePiggy]])
//        let category2 = Category(dictionary: ["title": "Meus Piggies", "about": "", "piggies":[myPiggy1, myPiggy2]])
//        let category3 = Category(dictionary: ["title": "Piggies Públicos", "about": "", "piggies":[myPiggy3, myPiggy4, myPiggy5]])
//        completion(nil, [category1, category2, category3])
//        return
        let keychain = KeychainSwift()
        let cpf = keychain.get("cpf")
        guard cpf != nil else {
            completion(NSError(domain: "", code: 0, userInfo: nil), nil)
            return
        }
        Alamofire.request("https://piggydigital.herokuapp.com/api/piggy/piggies?cpf=\(cpf!)", method: .get, parameters: nil, encoding: JSONEncoding.default).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                guard json["success"].boolValue != false else {
                    completion(NSError(domain: json["message"].stringValue, code: 0, userInfo: nil), nil)
                    return
                }
                var categories = [Category]()
                for (_,subJson):(String, JSON) in json["data"] {
                    let category = Category()
                    category.title = subJson["title"].stringValue
                    category.about = subJson["about"].stringValue
                    var piggies = [Piggy]()
                    for piggyJSON in subJson["piggies"] {
                        let piggy = Piggy(dictionary: piggyJSON.1.dictionaryObject!)
                        piggies.append(piggy)
                    }
                    category.piggies = piggies
                    categories.append(category)
                }
                completion(nil, categories)
            case .failure(let error):
                completion(error, nil)
            }
        }
    }
    
    class func newPiggy(piggy: Piggy, completion: @escaping (_ error: Error?) -> ()) {
        
        let keychain = KeychainSwift()
        let cpf = keychain.get("cpf")
        guard cpf != nil else {
            completion(NSError(domain: "", code: 0, userInfo: nil))
            return
        }
        if piggy.about == nil {
            piggy.about = ""
        }
        if piggy.isPublic == nil {
            piggy.isPublic = true
        }
        let params = ["cpf":cpf!,
                      "title":piggy.title!,
                      "about":piggy.about!,
                      "privacy":piggy.isPublic!,
                      "isPublic":piggy.isPublic!,
                      "image":"NONE"] as [String:Any]
//        if let image = image  {
//            let imageData = UIImageJPEGRepresentation(image, 0.5)
//            let base64String = imageData?.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
//            params["image"] = base64String
//        }
        Alamofire.request("https://piggydigital.herokuapp.com/api/piggy/create", method: .post, parameters: params, encoding: JSONEncoding.default).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                guard json["success"].boolValue != false else {
                    completion(NSError(domain: json["message"].stringValue, code: 0, userInfo: nil))
                    return
                }
                completion(nil)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    class func getExplore(completion: @escaping (_ error: Error?, _ banners: [Banner]?, _ categories: [Category]?) -> ()) {
        let path = Bundle.main.path(forResource: "Friends", ofType: "plist")
        let friends = NSArray(contentsOfFile: path!) as? [[String: String]]

        let path2 = Bundle.main.path(forResource: "ProjectFriend", ofType: "plist")
        let projectFriends = NSArray(contentsOfFile: path2!) as? [[String: String]]

        let banner1 = Banner()
        banner1.image = UIImage(named: "Banner1")!
        let banner2 = Banner()
        banner2.image = UIImage(named: "Banner2")!
        let banner3 = Banner()
        banner3.image = UIImage(named: "Banner3")!
        let banners = [banner1, banner2, banner3]
        
        let friend1 = Piggy(dictionary: ["type":1, "image":UIImage(named: friends![0]["Image"]!)!, "title":friends![0]["Name"]!, "alias":"@Friend1", "about":"Piggy Pessoal", "isPublic":true, "seeders":40, "savingsTier":2])
        let friend2 = Piggy(dictionary: ["type":1, "image":UIImage(named: friends![1]["Image"]!)!, "title":friends![1]["Name"]!, "alias":"@Friend2", "about":"Piggy Pessoal", "isPublic":true, "seeders":40, "savingsTier":2])
        let friend3 = Piggy(dictionary: ["type":1, "image":UIImage(named: friends![2]["Image"]!)!, "title":friends![2]["Name"]!, "alias":"@Friend3", "about":"Piggy Pessoal", "isPublic":true, "seeders":40, "savingsTier":2])
        let friend4 = Piggy(dictionary: ["type":1, "image":UIImage(named: friends![3]["Image"]!)!, "title":friends![3]["Name"]!, "alias":"@Friend4", "about":"Piggy Pessoal", "isPublic":true, "seeders":40, "savingsTier":2])
        let friend5 = Piggy(dictionary: ["type":1, "image":UIImage(named: friends![4]["Image"]!)!, "title":friends![4]["Name"]!, "alias":"@Friend5", "about":"Piggy Pessoal", "isPublic":true, "seeders":40, "savingsTier":2])

        
        let projectFriend1 = Piggy(dictionary: ["type":0, "image":UIImage(named: projectFriends![0]["Image"]!)!, "title":projectFriends![0]["Name"]!, "alias":"@ProjectFriend1", "about":"orem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque felis nunc", "isPublic":true, "seeders":40, "savingsTier":2])
        let projectFriend2 = Piggy(dictionary: ["type":0, "image":UIImage(named: projectFriends![1]["Image"]!)!, "title":projectFriends![1]["Name"]!, "alias":"@ProjectFriend2", "about":"orem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque felis nunc", "isPublic":true, "seeders":40, "savingsTier":2])
        let projectFriend3 = Piggy(dictionary: ["type":0, "image":UIImage(named: projectFriends![2]["Image"]!)!, "title":projectFriends![2]["Name"]!, "alias":"@ProjectFriend3", "about":"orem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque felis nunc", "isPublic":true, "seeders":40, "savingsTier":2])
        let projectFriend4 = Piggy(dictionary: ["type":0, "image":UIImage(named: projectFriends![3]["Image"]!)!, "title":projectFriends![3]["Name"]!, "alias":"@ProjectFriend4", "about":"orem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque felis nunc", "isPublic":true, "seeders":40, "savingsTier":2])
        let projectFriend5 = Piggy(dictionary: ["type":0, "image":UIImage(named: projectFriends![4]["Image"]!)!, "title":projectFriends![4]["Name"]!, "alias":"@ProjectFriend5", "about":"orem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque felis nunc", "isPublic":true, "seeders":40, "savingsTier":2])
        let projectFriend6 = Piggy(dictionary: ["type":0, "image":UIImage(named: projectFriends![5]["Image"]!)!, "title":projectFriends![5]["Name"]!, "alias":"@ProjectFriend6", "about":"orem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque felis nunc", "isPublic":true, "seeders":40, "savingsTier":2])


        let category = Category(dictionary: ["title": "Amigos do Facebook e Whatsapp", "about": "Todos os seus amigos do Facebook e Whatsapp aparecerão aqui. Piggies pessoais possuem possuem o formato redondo para distingui-lo dos demais.", "piggies":[friend1, friend2, friend3, friend4, friend5]])
        
        let category2 = Category(dictionary: ["title": "Projeto: Amigos de Valor", "about": "O Amigo de Valor é um dos maiores programas de mobilização social do Brasil. Baseado no Estatuto da Criança e do Adolescente (ECA), o programa contribui, desde 2002, para o fortalecimento dos Conselhos Municipais dos Direitos da Criança e do Adolescente.", "piggies":[projectFriend1, projectFriend2, projectFriend3, projectFriend4, projectFriend5, projectFriend6]])

        completion(nil, banners, [category, category2])
        return
        
//        Alamofire.request("https://piggydigital.herokuapp.com/api/piggy/explorer", method: .get, parameters: nil, encoding: JSONEncoding.default).responseJSON { response in
//            switch response.result {
//            case .success(let value):
//                let json = JSON(value)
//            case .failure(let error):
//                print(error)
//            }
//        }
    }
    
    
    class func updateActivePiggy(alias: String, completion: @escaping (_ error: Error?) -> ()) {
        
        let keychain = KeychainSwift()
        let cpf = keychain.get("cpf")
        guard cpf != nil else {
            completion(NSError(domain: "", code: 0, userInfo: nil))
            return
        }
        let params = ["cpf":cpf!,
                      "alias":alias] as [String:Any]
        Alamofire.request("https://piggydigital.herokuapp.com/api/piggy/update-active-piggy", method: .post, parameters: params, encoding: JSONEncoding.default).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                completion(nil)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private class func upload(image: UIImage,  completion: @escaping (_ success: Bool) -> ()) {
        let imageData = UIImagePNGRepresentation(image)!
        Alamofire.upload(imageData, to: "https://httpbin.org/post").responseJSON { response in
            debugPrint(response)
        }
    }
    
    private class func download(imageURL: URL,  completion: @escaping (_ success: Bool, _ image: UIImage) -> ()) {
        Alamofire.request(imageURL).responseData { response in
            if let data = response.result.value {
                let image = UIImage(data: data)
                completion(true, image!)
            }
        }
    }
}
