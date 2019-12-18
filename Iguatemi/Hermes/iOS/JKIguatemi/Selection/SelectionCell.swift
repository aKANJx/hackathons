//
//  SelectionCell.swift
//  JKIguatemi
//
//  Created by Jean Paul Marinho on 23/09/18.
//  Copyright © 2018 aKANJ. All rights reserved.
//

import UIKit

protocol SelectionCellDelegate {
    func deletePressed()
}

class SelectionCell: UICollectionViewCell {
    
    private struct Constants {
        static let animationSpeed: Float = 0.86
        static let rotationRadius: CGFloat = 15
    }
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var priceLabel: UILabel!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var aboutLabel: UILabel!
    var delegate: SelectionCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 12
    }
    
    override var center: CGPoint {
        didSet {
            updateVisual()
        }
    }
    
    @IBAction func deletePressed(_ sender: Any) {
        delegate?.deletePressed()
    }
    
    override internal func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        super.apply(layoutAttributes)
        updateVisual()
    }
    
    func updateVisual() {
        let rotation = atan2(transform.b, transform.a) * 100
        switch rotation {
        case -1 * Constants.rotationRadius ..< 0:
            break
        case Constants.rotationRadius ... CGFloat.greatestFiniteMagnitude:
            break
        default:
            break
        }
    }
}
