//
//  InfluencerSuggestionCell.swift
//  JKIguatemi
//
//  Created by Jean Paul Marinho on 22/09/18.
//  Copyright © 2018 aKANJ. All rights reserved.
//

import UIKit
import ANLoader

protocol  InfluencerStyleCellDelegate {
    func itemSelected(image: UIImage, index: Int)
}

class InfluencerStyleCell: UITableViewCell {

    @IBOutlet var collectionView: UICollectionView!
    var delegate: InfluencerStyleCellDelegate?
    var lookImages = [UIImage]()
    var looks = [String]() {
        didSet {
            fetchImages()
        }
    }
    
    func fetchImages() {
        for look in looks {
            let url = URL(string: look)
            let data = try? Data(contentsOf: url!)
            lookImages.append(UIImage(data: data!)!)
        }
        collectionView.reloadData()
        ANLoader.hide()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.dataSource = self
        collectionView.delegate = self
    }
}



extension InfluencerStyleCell: UICollectionViewDataSource, UICollectionViewDelegate  {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return lookImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! InfluencerStyleCollectionCell
        cell.imageView.image = lookImages[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            let cell = collectionView.cellForItem(at: indexPath) as! InfluencerStyleCollectionCell
            cell.checkImageView.isHidden = !cell.checkImageView.isHidden
            delegate?.itemSelected(image: cell.imageView.image!, index: indexPath.row)
        }
    }
}
