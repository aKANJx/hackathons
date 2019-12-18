//
//  BarCodeViewController.swift
//  AngelHack
//
//  Created by Jean Paul Marinho on 16/04/16.
//  Copyright © 2016 Jean Paul Marinho. All rights reserved.
//

import UIKit
import AVFoundation
import AlamofireImage
import BarCodeReaderView

protocol BarcodeDelegate {
    func barcodeReaded(barcode: String)
}

class BarCodeViewController: UIViewController {
    
    var barcodeReader: BarcodeReaderView?
    var product: Product?
    @IBOutlet weak var productModal: UIView!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var imgCarrinho: UIImageView!
    @IBOutlet weak var shutterCamera: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.barcodeReader = BarcodeReaderView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        self.view.addSubview(barcodeReader!)
        self.barcodeReader!.delegate = self
        self.barcodeReader!.barCodeTypes = [.EAN13Code]
        self.productName.numberOfLines = 0
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        AppData.sharedInstance.delegate = self
        imgCarrinho.layer.zPosition = 100
        self.shutterCamera.layer.zPosition = 100
        self.barcodeReader!.startCapturing()
    }

    @IBAction func text(sender: AnyObject) {
        let titlePrompt = UIAlertController(title: "Código de Barras", message: "Digite o número do código de barras", preferredStyle: .Alert)
        
        var titleTextField: UITextField?
        titlePrompt.addTextFieldWithConfigurationHandler { (textField) -> Void in
            titleTextField = textField
            textField.placeholder = ""
            textField.keyboardType = UIKeyboardType.DecimalPad
            textField.textAlignment = NSTextAlignment.Center
        }
        let cancelAction: UIAlertAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .Cancel, handler: nil)
        titlePrompt.addAction(cancelAction)
        titlePrompt.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
            let count = titleTextField?.text?.characters.count
            if count != 8 || count != 13 || count != 14 {
                return
            }
            self.barcodeReader?.stopCapturing()
            self.barcodeReader?.removeFromSuperview()
            AppNotifications.showLoadingIndicator("Comunicando-se com o servidor...")
            GSIAPI.sharedInstance.makeHTTPGetRequest(titleTextField!.text!)
        }))
        
        self.presentViewController(titlePrompt, animated: true, completion: nil)
    }
    
    func productModalHandle () {
        self.productModal.hidden = true
        self.imgCarrinho.hidden = false
        self.productImage.image = nil
        self.productName.text = ""
    }
    
    @IBAction func closeButtonPressed(sender: UIButton) {
        productModalHandle()
    }
    
    //Método que salva o produto depois de encontrado no servidor
    @IBAction func checkButtonPressed(sender: UIButton) {
        AppNotifications.showLoadingIndicator("Adicionando à sua lista...")
        AppData.sendProduct(self.product!)
    }
}



extension BarCodeViewController: BarcodeReaderViewDelegate {
    //Método para tratar o erro na leitura do código de barras
    func barcodeReader(barcodeReader: BarcodeReaderView, didFailReadingWithError error: NSError) {
        print("Erro na leitura: ", error)
    }

    //Método que captura o GTIN do código de barras e manda para a procura na API da GS1
    func barcodeReader(barcodeReader: BarcodeReaderView, didFinishReadingString info: String) {
        AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
        self.barcodeReader?.stopCapturing()
        self.barcodeReader?.removeFromSuperview()
        AppNotifications.showLoadingIndicator("Comunicando-se com o servidor...")
        GSIAPI.sharedInstance.makeHTTPGetRequest(info)
    }
}



extension BarCodeViewController: AppDataDelegate {
    
    func productIsReadyToShow(product: Product) {
        self.product = product
        AppNotifications.hideLoadingIndicator()
        if product.name == "" {
            AppNotifications.showAlertController("Código do produto Inválido!", message: nil, presenter: self, okHandler: { (UIAlertAction) in
                self.barcodeReader?.stopCapturing()
                self.barcodeReader = BarcodeReaderView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
                self.barcodeReader!.delegate = self
                self.barcodeReader!.barCodeTypes = [.EAN13Code]
                self.barcodeReader?.startCapturing()
                self.view.insertSubview(self.barcodeReader!, belowSubview: self.productModal)
            })
        }
        else {
            self.productModal.hidden = false
            imgCarrinho.hidden = true
            self.navigationController?.title = "Scanner"
            self.productName.text = product.name!
            guard let img = product.image else {
                return
            }
            guard let imgURL = NSURL(string: img) else {
                return
            }
            self.productImage.af_setImageWithURL(imgURL, placeholderImage: UIImage(named: "placeholder"))
            self.view.setNeedsDisplay()
            self.barcodeReader?.stopCapturing()
            self.barcodeReader = BarcodeReaderView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
            self.barcodeReader!.delegate = self
            self.barcodeReader!.barCodeTypes = [.EAN13Code]
            self.barcodeReader?.startCapturing()
            self.view.insertSubview(barcodeReader!, belowSubview: self.productModal)
        }
    }
    
    func sendProductWithSuccess(success: Bool) {
        AppNotifications.hideLoadingIndicator()
        if success == true {
            AppNotifications.showAlertController("Item adicionado com sucesso", message: nil, presenter: self) { (UIAlertAction) in
            }
        }
        else {
            AppNotifications.showAlertController("Item já existe no banco de dados. Por favor, adicione um item diferente", message: nil, presenter: self) { (UIAlertAction) in
            }
        }
        self.productModalHandle()
    }
    
    func getMarketsWithSuccess(success: Bool) {
    }
    
    func getPromotionsWithSuccess(success: Bool) {
        
    }
    
    func getProductsWithSuccess(success: Bool) {
    }
}

