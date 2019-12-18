//
//  DashboardViewController.swift
//  FoodKids
//
//  Created by Jean Paul Marinho on 19/08/18.
//  Copyright © 2018 Expresso MovHack Expresso MovHack Expresso MovHack Expresso MovHack. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    var homeCellsTitle = [
        "Sem medo!", "Fazendinha fit", "De última hora!", "Férias até R$30,00", "Criança feliz :)", "Só risadas"]
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}



extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "homeCell", for: indexPath) as! HomeCell
        cell.imageView.image = UIImage(named: "homeCell\(indexPath.row+1)")
        cell.titleLabel.text = self.homeCellsTitle[indexPath.row]
        return cell
    }
    
    
}
