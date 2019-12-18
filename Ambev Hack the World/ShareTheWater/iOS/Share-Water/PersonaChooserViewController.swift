//
//  PersonaChooserViewController.swift
//  Share-Water
//
//  Created by Jean Paul Marinho on 15/02/17.
//  Copyright © 2017 aKANJ. All rights reserved.
//

import UIKit
import GhostTypewriter

class PersonaChooserViewController: UIViewController {
    @IBOutlet var titleLabel: TypewriterLabel!
    @IBOutlet var collectionView: UICollectionView!
    var personaChooserOptions = [[String:Any]]()
    var cardsIsVisible = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let path = Bundle.main.path(forResource: "PersonaChooser", ofType: "plist") {
            if let array = NSArray(contentsOfFile: path) as? [[String: Any]] {
                self.personaChooserOptions = array
            }
        }
        self.titleAnimationInit()
    }
    
    func titleAnimationInit() {
        self.titleLabel.typingTimeInterval = 0.01
        self.titleLabel.startTypewritingAnimation {
            self.cardsIsVisible = true
            self.collectionView.reloadData()
        }
    }
}



extension PersonaChooserViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! PersonaChooserCardCell
        guard self.cardsIsVisible == true else {
            cell.alpha = 0
            return cell
        }
        let persona = self.personaChooserOptions[indexPath.row]
        cell.imageView.image = UIImage(named: persona["image"] as! String)
        cell.titleLabel.text = persona["title"] as! String?
        cell.aboutLabel.text = persona["about"] as! String?
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            cell.alpha = 1
        }, completion: nil)
        return cell
    }
}



extension PersonaChooserViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "ToMoneyDonatorVC", sender: nil)
    }
    
}
