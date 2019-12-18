//
//  CarDataViewController.swift
//  Torq
//
//  Created by Jean Paul Marinho on 20/10/18.
//  Copyright © 2018 aKANJ. All rights reserved.
//

import UIKit

class CarDataViewController: UIViewController {
    
    @IBOutlet weak var carDataCollectionView: UICollectionView!
    @IBOutlet weak var lblTitle: UIButton!
    
    var car: Car!
    
    let categories: [CarCategory] = [
        CarCategory(categoryId: "engine", category: "Mecânica", image: "engine-white"),
        CarCategory(categoryId: "gear", category: "Elétrica", image: "electricIcon"),
        CarCategory(categoryId: "security", category: "Segurança", image: "bealt-white"),
        CarCategory(categoryId: "visual", category: "Visual", image: "car-white-3")
    ]
    
    let color = ["fc4f43", "7cc7a7", "84c5e4", "146c8f"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.car = AppInfo.shared.car
        self.title = "\(car.brand) \(car.model)"
        self.tabBarItem.image = UIImage(named: "carDataTab")
        carDataCollectionView.delegate = self
        carDataCollectionView.dataSource = self
        carDataCollectionView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else {
            return
        }
        
        switch identifier {
        case "segueToCarCategoryDetail":
            (segue.destination as? CarCategoryDetailViewController)?.category = sender as? CarCategory
            
        case "segueToCarPriceHistoryViewController":
            (segue.destination as? CarPriceHistoryViewController)?.car = sender as? Car
        default:
            break
        }
    }
    
    @IBAction func showPriceHistory(_ sender: Any) {
        performSegue(withIdentifier: "segueToCarPriceHistoryViewController", sender: nil)
    }
}

extension CarDataViewController: UICollectionViewDelegate {
    
}

extension CarDataViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let category: CarCategory = categories[indexPath.row]
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CarCategoryCollectionViewCell", for: indexPath) as? CarCategoryCollectionViewCell {
            cell.lblTitle.text = category.category
            cell.imgcategory.image = UIImage(named: category.image!)
            cell.backgroundColor = UIColor(hexString: color[indexPath.row])
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "segueToCarCategoryDetail", sender: categories[indexPath.row])
    }
}
