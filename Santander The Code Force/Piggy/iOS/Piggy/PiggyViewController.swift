//
//  PiggyDetailViewController.swift
//  Piggy
//
//  Created by Jean Paul Marinho on 13/01/17.
//  Copyright © 2017 aKANJ. All rights reserved.
//

import UIKit
import AVFoundation
import SpriteKit
import Hero

class PiggyViewController: UIViewController {
    
    @IBOutlet weak var coinsDropView: SKView!
    @IBOutlet weak var piggyBackgroundView: UIView!
    @IBOutlet weak var piggyAccessory: UIView!
    @IBOutlet weak var tableView: UITableView!
    var piggy: Piggy!
    let coinsDropScene = CoinsDropScene()
    var piggyFX: [[String:Any]]!
    var player: AVAudioPlayer?
    var friends: [[String:String]]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let friendPath = Bundle.main.path(forResource: "Friends", ofType: "plist")
        self.friends = NSArray(contentsOfFile: friendPath!) as? [[String: String]]
        self.piggyBackgroundView.layer.cornerRadius = 15
        self.view.backgroundColor = UIColor.clear
        self.piggyAccessory.layer.cornerRadius = self.piggyAccessory.frame.height / 2.0
        let path = Bundle.main.path(forResource: "PiggyFX", ofType: "plist")
        self.piggyFX = NSArray(contentsOfFile: path!) as? [[String: Any]]
        self.coinsDropView.allowsTransparency = true
        self.coinsDropScene.backgroundColor = UIColor.clear
        self.coinsDropView.presentScene(self.coinsDropScene)
        self.tableView.register(UINib(nibName: "CategoryCell", bundle: nil), forCellReuseIdentifier: "categoryCell")
        self.tableView.register(UINib(nibName: "FriendsHeaderSection", bundle: nil), forHeaderFooterViewReuseIdentifier: "friendsHeader")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.coinsDropScene.droppingCoins()
        Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { timer in
            self.coinsDropScene.stopCoinsDropping()
        }
    }
    
    @IBAction func topViewPanning(_ sender: UIPanGestureRecognizer) {
        if sender.velocity(in: self.view).y > 0
        {
            self.dismiss(animated: true)
        }
    }
    
    @IBAction func coinDropViewTapped(_ sender: UITapGestureRecognizer) {
        self.dismiss(animated: true)
    }
    
    override func motionBegan(_ motion: UIEventSubtype, with event: UIEvent?) {
        
        let url = Bundle.main.url(forResource: "Coin-shake3" as? String, withExtension: "mp3")!
        do {
            player = try AVAudioPlayer(contentsOf: url)
            guard let player = player else { return }
            
            player.prepareToPlay()
            player.play()
        } catch let error {
            print(error.localizedDescription)
        }
    }
}



extension PiggyViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            if piggy.type! == .personal {
                return 1
            }
            else {
                return 2
            }
        default:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "headerCell") as! PiggyHeaderCell
                cell.piggyImageView.image(image: piggy.image!, withType: piggy.type!)
                cell.titleLabel.text = piggy.title!
                return cell
            }
            else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "aboutCell") as! PAboutCell
                cell.aboutTextView.text = self.piggy.about!
                return cell
            }
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell") as! CategoryCell
            cell.setCollectionViewDataSourceDelegate(dataSourceDelegate: self, forSection: indexPath.section)
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "shareCell") as! PShareCell
            cell.delegate = self
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            if indexPath.row == 0 {
                return 200
            }
            else {
                return 80
            }
        case 1:
            return 150
        default:
            return 50
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 1:
            let cell = tableView.dequeueReusableHeaderFooterView(withIdentifier: "friendsHeader")
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 1:
            return 70
        default:
            return 0
        }
    }
}



extension PiggyViewController: UITableViewDelegate {
}



extension PiggyViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (scrollView.contentOffset.y < 0){
            self.dismiss(animated: true, completion: nil)
        }
    }
}



extension PiggyViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (self.friends?.count)!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryItemCell", for: indexPath) as! CategoryItemCell
        cell.piggyImageView.image(image: UIImage(named: (self.friends?[indexPath.row]["Image"]!)!)!, withType: .personal)
        cell.titleLabel.text = (self.friends?[indexPath.row]["Name"]!)!
        cell.seedersView.isHidden = true
        return cell
    }
}



extension PiggyViewController: UICollectionViewDelegate {
}



extension PiggyViewController: UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 130)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 140, bottom: 0, right: 0)
    }
}



extension PiggyViewController: PShareCellDelegate {
    
    func sharePressed() {
        NotificationController.shared.showActivity(viewController: self)
    }
}
