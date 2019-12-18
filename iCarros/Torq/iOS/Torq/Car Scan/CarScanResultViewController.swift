//
//  CarScanResultViewController.swift
//  Torq
//
//  Created by Jean Paul Marinho on 21/10/18.
//  Copyright © 2018 aKANJ. All rights reserved.
//

import UIKit

class CarScanResultViewController: UIViewController {

    @IBOutlet var brandLabel: UILabel!
    @IBOutlet var modelLabel: UILabel!
    @IBOutlet var detailLabel: UILabel!
    @IBOutlet var plateLabel: UILabel!
    @IBOutlet var brandImageView: UIImageView!
    @IBOutlet var carImageView: UIImageView!
    var result: String! {
        didSet {
            let resultComponents = result.components(separatedBy: "-")
            brand = resultComponents[0].capitalizingFirstLetter()
            model = resultComponents[1].capitalizingFirstLetter()
            year = resultComponents[2]
            car = Car(brand:brand, model: model, year: Int(year)!)
        }
    }
    var brand: String!
    var model: String!
    var year: String!
    
    var car: Car!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Registro de Carro"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        brandLabel.text = "\(brand!)"
        modelLabel.text = "\(model!)"
        var segment = "SI"
        if brand == "toyota" {
            segment = "XEI"
        }
        detailLabel.text = "\(segment) - \(year!)"
        brandImageView.image = UIImage(named: "\(brand!)Logo")
        carImageView.image = UIImage(named: "\(model!)Profile")
    }
    
    @IBAction func showMain(_ sender: Any) {
        AppInfo.shared.car = self.car
        let sb = UIStoryboard(name: "Main", bundle: nil)
        UIApplication.shared.keyWindow?.rootViewController = sb.instantiateInitialViewController()
        UIApplication.shared.keyWindow?.makeKeyAndVisible()
    }
}
