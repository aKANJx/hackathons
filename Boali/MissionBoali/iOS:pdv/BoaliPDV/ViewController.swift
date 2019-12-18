//
//  ViewController.swift
//  BoaliPDV
//
//  Created by Jean Paul Marinho on 25/08/19.
//  Copyright © 2019 aKANJ. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var collectionView: UICollectionView!
    var orders = [Order]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (timer) in
            APIClient.getOrder { (orders) in
                self.orders = orders
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        }
    }
    
}



extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: 300)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return orders.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OrderCell", for: indexPath) as! OrderCell
        cell.cellNumberLabel.text = "\(indexPath.row+1)"
        cell.itemsLabel.text = orders[indexPath.row].description
        return cell

    }
}
