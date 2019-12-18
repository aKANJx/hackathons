//
//  InfluencerOtherCell.swift
//  JKIguatemi
//
//  Created by Jean Paul Marinho on 22/09/18.
//  Copyright © 2018 aKANJ. All rights reserved.
//

import UIKit

class InfluencerOtherCell: UITableViewCell {

    @IBOutlet var collectionView: UICollectionView!
   var namesString = [String]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.dataSource = self
        collectionView.delegate = self
        fetchSimilars()
    }
    
    func fetchSimilars() {
        if let URL = Bundle.main.url(forResource: "Similars", withExtension: "plist") {
            if let plistRes = NSArray(contentsOf: URL) as? [String] {
                 namesString = plistRes
            }
        }
        collectionView.reloadData()
    }
}
    



extension InfluencerOtherCell: UICollectionViewDataSource, UICollectionViewDelegate  {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! InfluencerCollectionCell
        cell.imageView.image = UIImage(named: "person\(indexPath.row + 1)")
        cell.nameLabel.text = namesString[indexPath.row]
        return cell
    }
}

