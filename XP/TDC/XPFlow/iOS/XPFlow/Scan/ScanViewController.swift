//
//  ViewController.swift
//  OnboardingXP
//
//  Created by Jean Paul Marinho on 20/07/19.
//  Copyright © 2019 aKANJ. All rights reserved.
//

import UIKit
import VisionKit
import Vision

protocol ScanViewControllerDelegate {
    func didScanned(socialID: SocialID)
}


class ScanViewController: UIViewController {

    var delegate: ScanViewControllerDelegate?
    var socialID: SocialID?
    var hasScanned = false
    var completionHandler: ((SocialID) -> Void)?
    
    func startRecognition(from vc: UIViewController, completion: @escaping ((SocialID) -> Void)) {
        completionHandler = completion
        let scanVC = VNDocumentCameraViewController()
        scanVC.delegate = self
        vc.present(scanVC, animated: true, completion: nil)
    }
    
    func recognizeText(using cgImage: CGImage) {
        let requestHandler = VNImageRequestHandler(cgImage: cgImage, options: [:])
        let request = VNRecognizeTextRequest { (request, error) in
            guard let observations = request.results as? [VNRecognizedTextObservation] else { return }
            var fullText = ""
            for observation in observations {
                let topCandidate = observation.topCandidates(1)
                if let recognizedText = topCandidate.first {
                    fullText += "\(recognizedText.string)\n"
                }
            }
            self.structure(text: fullText)
        }
        request.recognitionLevel = .accurate
        request.recognitionLanguages = ["pt-BR"]
        request.usesLanguageCorrection = true
        try? requestHandler.perform([request])
    }
    
    func structure(text: String) {
        let scannedFields = text.components(separatedBy: .newlines)
        let isCNH = scannedFields.contains(where: { (element) -> Bool in
            element.contains("HABILITA")
        })
        let name = scannedFields[findIndex(using: "NOME", in: scannedFields) + 1]
        var cpf = ""
        if !isCNH {
             cpf = scannedFields[findIndex(using: "CPF", in: scannedFields) + 1]
        }
        else {
            cpf = scannedFields[findIndex(using: "CPF", in: scannedFields) + 2].truncate(length: 14)
        }
        let filiation = scannedFields[findIndex(using: "FILIACAO", in: scannedFields) + 1]
        var birthdate = ""
        if !isCNH {
            birthdate = scannedFields[findIndex(using: "DATA DE NASCIMENTO", in: scannedFields) + 1]
            if !birthdate.isDate() {
                birthdate = scannedFields[findIndex(using: "DATA DE NASCIMENTO", in: scannedFields) + 2]
            }
        }
        else {
            birthdate = String(scannedFields[findIndex(using: "DATA NASCIMENTO", in: scannedFields) + 1].suffix(10))
        }
        let age = calculateAge(birthday: birthdate)
        
        var rgField = ""

        if !isCNH {
            rgField = "REGISTRO GERAL"
        }
        else {
            rgField = "IDENTIDADE /"
        }
        var rg = scannedFields[findIndex(using: rgField, in: scannedFields) + 1]
        rg = rg.replacingOccurrences(of: ".", with: "").replacingOccurrences(of: "-", with: "")
        if !rg.isDigits {
            rg = scannedFields[findIndex(using: rgField, in: scannedFields) + 2].replacingOccurrences(of: ".", with: "").replacingOccurrences(of: "-", with: "")
        }
        if isCNH {
            if !rg.isDigits {
                       rg = scannedFields[findIndex(using: rgField, in: scannedFields) + 3].replacingOccurrences(of: ".", with: "").replacingOccurrences(of: "-", with: "")
                   }
                   if !rg.isDigits {
                       rg = scannedFields[findIndex(using: rgField, in: scannedFields) + 4].replacingOccurrences(of: ".", with: "").replacingOccurrences(of: "-", with: "")
                   }
        }
        let socialID = SocialID(name: name,
                                filiationName: filiation,
                                nationality: "",
                                age: age,
                                rg: rg,
                                cpf: cpf)
        self.socialID = socialID
    }
    
    func findIndex(using field: String, in scannedFields: [String]) -> Int {
        for scannedField in scannedFields {
            if field.contains(scannedField.uppercased()) {
                return scannedFields.firstIndex(of: scannedField)!
            }
        }
        return 0
    }
    
    func calculateAge(birthday: String) -> Int {
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "dd/MM/yyyy"
        let birthdayDate = dateFormater.date(from: birthday.truncate(length: 10))
        let calendar = NSCalendar(calendarIdentifier: .gregorian)
        let now = Date()
        let calcAge = calendar!.components(.year, from: birthdayDate ?? Date(), to: now, options: [])
        let age = calcAge.year
        return age!
    }
}



extension ScanViewController: VNDocumentCameraViewControllerDelegate {
    
    
    func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFinishWith scan: VNDocumentCameraScan) {
        hasScanned = true
        let image = scan.imageOfPage(at: 0)
        guard let cgImage = image.cgImage else { return }
        self.recognizeText(using: cgImage)
        controller.dismiss(animated: true) {
            self.completionHandler?(self.socialID!)
        }
    }
}



extension String {
    
    func isDate() -> Bool {
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "dd/MM/yyyy"
        let birthdayDate = dateFormater.date(from: self.truncate(length: 10))
        return birthdayDate != nil
    }
    
    func truncate(length: Int) -> String {
        return (self.count > length) ? String(self.prefix(length)) : self
      }
    
    var isDigits: Bool {
       guard !self.isEmpty else { return false }
       return !self.contains { Int(String($0)) == nil }
     }
}
