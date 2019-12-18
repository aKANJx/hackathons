//
//  BroadcastCell.swift
//  JKIguatemi
//
//  Created by Jean Paul Marinho on 22/09/18.
//  Copyright © 2018 aKANJ. All rights reserved.
//

import UIKit
import algorithmia
import ANLoader
import UIImageColors

protocol BroadcastCellDelegate {
    func mlFinished(with wears: [Wear])
}

class BroadcastCell: UITableViewCell {

    @IBOutlet var styleImageView: UIImageView!
    @IBOutlet var collectionView: UICollectionView!
    var lookImage: UIImage?
    var delegate: BroadcastCellDelegate?
    var imageURL: URL? {
        didSet {
            DispatchQueue.main.async {
                self.fetchML()
            }
        }
    }
    var wears = [Wear]()
    var wearImages = [UIImage]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.dataSource = self
        collectionView.delegate = self
        styleImageView.layer.cornerRadius = 12
    }
    
    func fetchML() {
        ANLoader.showLoading()
        let data = try? Data(contentsOf: imageURL!)
        if let imageData = data {
            styleImageView.image = UIImage(data: imageData)
        }
        let input = "{"
            + "  \"image\": \"\(imageURL!)\","
            + "  \"model\": \"small\","
            + "  \"tags_only\": true"
            + "}";
        let client = Algorithmia.client(simpleKey: "simfKLbuEF4N1tN+q/QrjWml+EO1")
        let algo = client.algo(algoUri: "algorithmiahq/DeepFashion/1.3.0")
        algo.pipe(rawJson: input) { resp, error in
            let decoder = JSONDecoder()
            let jsonData = try! JSONSerialization.data(withJSONObject: resp.getJson(), options: JSONSerialization.WritingOptions.prettyPrinted)
            let algorithmiaResponse = try! decoder.decode(AlgorithmiaResponse.self, from: jsonData)
            self.wears = algorithmiaResponse.articles
            DispatchQueue.main.async {
                self.collectionView.reloadData()
                ANLoader.hide()
            }
        }
    }
    
    func fillColors() {
        var index = 0
        var wearsMod = [Wear]()
        for wear in wears {
            var wearMod = wear
            wearMod.primaryColor = wearImages[index].getColors().primary.toHexString()
            wearsMod.append(wearMod)
            index += 1
        }
        delegate?.mlFinished(with: wearsMod)
    }
}



extension BroadcastCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        let totalCellWidth = 80 * collectionView.numberOfItems(inSection: 0)
        let totalSpacingWidth = 10 * (collectionView.numberOfItems(inSection: 0) - 1)
        
        let leftInset = (collectionView.layer.frame.size.width - CGFloat(totalCellWidth + totalSpacingWidth)) / 2
        let rightInset = leftInset
        
        return UIEdgeInsets(top: 0, left: leftInset, bottom: 0, right: rightInset)
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return wears.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let wear = wears[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! BroadcastCollectionCell
        let data = try? Data(contentsOf: imageURL!)
        DispatchQueue.main.async {
            if let imageData = data {
                let imageRAW = UIImage(data: imageData)
                let wearImage = imageRAW?.cropped(boundingBox: CGRect(x: wear.boundingBox.x0, y: wear.boundingBox.y0, width: wear.boundingBox.x1/2, height: wear.boundingBox.y1/2))
                self.wearImages.append(wearImage!)
                if self.wearImages.count == self.wears.count {
                    self.fillColors()
                }
                cell.imageView.image = wearImage
            }
        }
        cell.aboutLabel.text = "\(wear.name.capitalizingFirstLetter())"
        cell.confidenceLabel.text = "\(String(format: "%.2f", wear.confidence*100))%"
        return cell
    }
}
