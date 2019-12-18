//
//  AbilityViewController.swift
//  ZipRecruiter
//
//  Created by Jean Paul Marinho on 07/05/17.
//  Copyright © 2017 aKANJ. All rights reserved.
//

import UIKit

class AbilityViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    var abilities = [Ability]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadAbilities()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func loadAbilities() {
        let path = Bundle.main.url(forResource: "Ability", withExtension: "plist")
        let array = NSArray(contentsOf: path!) as! [String]
        for item in array {
            let ability = Ability()
            ability.title = item
            self.abilities.append(ability)
        }
    }
    
    @IBAction func donePressed(_ sender: UIButton) {
        UIApplication.shared.keyWindow?.rootViewController = self.storyboard?.instantiateViewController(withIdentifier: "ExploreViewController")
        
    }
}


extension AbilityViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.abilities.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! AbilityCell
        let ability = self.abilities[indexPath.row]
        if ability.intensityLevel == 0 {
            cell.backgroundColor = UIColor.darkGray
        }
        else {
            cell.backgroundColor = UIColor(red: 0.43, green: 0.78, blue: 0.34, alpha: 1)
        }
        cell.title.text = ability.title!.replacingOccurrences(of: "-", with: " ")
        return cell
    }
}


extension AbilityViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let interest = self.abilities[indexPath.row]
        interest.intensityLevel = interest.intensityLevel + 1
        if interest.intensityLevel > 1 {
            interest.intensityLevel = 0
        }
        collectionView.reloadData()
    }
}
