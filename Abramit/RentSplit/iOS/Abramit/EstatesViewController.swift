//
//  EstatesViewController.swift
//  Abramit
//
//  Created by Jean Paul Marinho on 15/11/17.
//  Copyright © 2017 aKANJ. All rights reserved.
//

import UIKit

class EstatesViewController: UIViewController {

    @IBOutlet var collectionView: UICollectionView!
    var estates = [Estate]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        APIClient.getEstates { (estates) in
            self.estates = estates
            self.collectionView.reloadData()
        }
    }
    
}



extension EstatesViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.estates.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! EstatesCell
        let estate = self.estates[indexPath.row]
        cell.priceLabel.text = "R$\(estate.price)"
        cell.addressLabel.text = estate.address
        cell.imageView.image = UIImage(named: "\(estate.id)")
        cell.numberOfPeople.text = "\(estate.residents)/\(estate.capacity)"
        return cell
    }
}



extension EstatesViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "DetailSegue", sender: indexPath.row)
    }
    
}
