//
//  BannerTableViewCell.swift
//  Piggy
//
//  Created by Jean Paul Marinho on 11/01/17.
//  Copyright © 2017 aKANJ. All rights reserved.
//

import UIKit

class CategoryCell: UITableViewCell {

    @IBOutlet var collectionView: UICollectionView!
    
    func setCollectionViewDataSourceDelegate
        <D: protocol<UICollectionViewDataSource, UICollectionViewDelegate>>
        (dataSourceDelegate: D, forSection section: Int) {
        collectionView.register(UINib(nibName: "BannerCell", bundle: nil), forCellWithReuseIdentifier: "bannerCell")
        collectionView.register(UINib(nibName: "CategoryItemCell", bundle: nil), forCellWithReuseIdentifier: "categoryItemCell")
        collectionView.delegate = dataSourceDelegate
        collectionView.dataSource = dataSourceDelegate
        collectionView.tag = section
        collectionView.reloadData()
    }
}
