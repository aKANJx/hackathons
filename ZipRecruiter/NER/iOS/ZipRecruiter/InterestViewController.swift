//
//  InterestsViewController.swift
//  ZipRecruiter
//
//  Created by Jean Paul Marinho on 06/05/17.
//  Copyright © 2017 aKANJ. All rights reserved.
//

import UIKit
import Hero

class InterestViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    var interests = [Interest]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadInterests()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func loadInterests() {
        let path = Bundle.main.url(forResource: "Interest", withExtension: "plist")
        let array = NSArray(contentsOf: path!) as! [String]
        for item in array {
            let interest = Interest()
            interest.title = item
            interest.imageName = "\(item)"
            self.interests.append(interest)
        }
    }
    
    @IBAction func nextPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "ToAbilitiesVC", sender: nil)

    }
}


extension InterestViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.interests.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! InterestCell
        let interest = self.interests[indexPath.row]
        cell.title.text = interest.title!.replacingOccurrences(of: "-", with: " ")
        let imageName = "\(interest.imageName!)-\(interest.intensityLevel)"
        cell.imageBackground.image = UIImage(named: imageName)
        return cell
    }
}


extension InterestViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let interest = self.interests[indexPath.row]
        interest.intensityLevel = interest.intensityLevel + 1
        if interest.intensityLevel > 2 {
            interest.intensityLevel = 0
        }
        collectionView.reloadData()
    }
}
