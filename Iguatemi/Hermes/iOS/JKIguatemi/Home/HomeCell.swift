//
//  SearchCell.swift
//  JKIguatemi
//
//  Created by Jean Paul Marinho on 22/09/18.
//  Copyright © 2018 aKANJ. All rights reserved.
//

import UIKit

class HomeCell: UITableViewCell {

    @IBOutlet var profileImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var usernameLabel: UILabel!
    @IBOutlet var followersCount: UILabel!
    @IBOutlet var collectionView: UICollectionView!
    var namesString = [String]()
    var storesString = [String]()
    var currentNumber = 1
    var nextInt = 1
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.dataSource = self
        collectionView.delegate = self
        fetchSimilars()
        fetchStores()
    }
    
    func fetchSimilars() {
        if let URL = Bundle.main.url(forResource: "Selection", withExtension: "plist") {
            if let plistRes = NSArray(contentsOf: URL) as? [String] {
                namesString = plistRes
            }
        }
    }
    
    func fetchStores() {
        if let URL = Bundle.main.url(forResource: "Stores", withExtension: "plist") {
            if let plistRes = NSArray(contentsOf: URL) as? [String] {
                storesString = plistRes
            }
        }
        collectionView.reloadData()
    }
    
    func generateRandomNumber() {
        repeat {
            nextInt = Int.random(in: 1 ..< 6)
        } while currentNumber == nextInt
    }
}



extension HomeCell: UICollectionViewDataSource, UICollectionViewDelegate  {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! HomeAdCell
        generateRandomNumber()
        cell.imageView.image = UIImage(named: "ad\(nextInt)")
        if namesString.count > 0 {
            cell.aboutLabel.text = namesString[Int.random(in: 1 ..< 6)]
        }
        if storesString.count > 0 {
            cell.storeLabel.text = storesString[Int.random(in: 1 ..< 4)]
        }
        return cell
    }
}
