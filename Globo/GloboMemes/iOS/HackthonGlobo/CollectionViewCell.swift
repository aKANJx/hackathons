/**
 This file is part of the SFFocusViewLayout package.
 (c) Sergio Fernández <fdz.sergio@gmail.com>

 For the full copyright and license information, please view the LICENSE
 file that was distributed with this source code.
 */

import UIKit

protocol CollectionViewCellInterface {

    func setTitle(text: String)
    func setDescription(text: String)
    func setBackground(image: UIImage)
    func setUrl(text: String)
    func getVideoView() -> VideoView
}

class CollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var overlayView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var videoView: VideoView!
    @IBOutlet weak var recordButton: UIButton! {
        didSet {
            recordButton.layer.borderColor = UIColor.clear.cgColor
            recordButton.layer.borderWidth = 1.0
            recordButton.layer.cornerRadius = 20
            recordButton.clipsToBounds = true
        }
    }

    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        super.apply(layoutAttributes)

        let featuredHeight: CGFloat = Constant.featuredHeight
        let standardHeight: CGFloat = Constant.standardHegiht

        let delta = 1 - (featuredHeight - frame.height) / (featuredHeight - standardHeight)

        let minAlpha: CGFloat = Constant.minAlpha
        let maxAlpha: CGFloat = Constant.maxAlpha

        let alpha = maxAlpha - (delta * (maxAlpha - minAlpha))
        overlayView.alpha = alpha

        let scale = max(delta, 0.5)
        titleLabel.transform = CGAffineTransform(scaleX: scale, y: scale)

        descriptionLabel.alpha = delta
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.contentView.autoresizingMask.insert(.flexibleHeight)
        self.contentView.autoresizingMask.insert(.flexibleWidth)
    }
}

extension CollectionViewCell: CollectionViewCellInterface {

    func setTitle(text: String) {
        self.titleLabel.text = text
    }

    func setDescription(text: String) {
        self.descriptionLabel.text = text
    }

    func setBackground(image: UIImage) {
        self.backgroundImageView.image = image
    }
    
    func setUrl(text: String) {
        self.videoView.configure(url: text)
        self.videoView.isLoop = true
    }
    
    func getVideoView() -> VideoView {
        return self.videoView
    }
}

private extension CollectionViewCell {
    struct Constant {
        static let featuredHeight: CGFloat = 280
        static let standardHegiht: CGFloat = 100

        static let minAlpha: CGFloat = 0.2
        static let maxAlpha: CGFloat = 0.4
    }
}

extension CollectionViewCell : NibLoadableView { }
