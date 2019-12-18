//
//  ExploreViewController.swift
//  Piggy
//
//  Created by Jean Paul Marinho on 11/01/17.
//  Copyright © 2017 aKANJ. All rights reserved.
//

import UIKit
import Hero

class ExploreViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    var banners: [Banner]?
    var categories: [Category]?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UINib(nibName: "CategoryCell", bundle: nil), forCellReuseIdentifier: "categoryCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.reloadPiggies()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToPublicPiggyVC" {
            let vc = segue.destination as! PublicPiggyViewController
            vc.transitioningDelegate = self
            let exploreIndexPath = sender as! IndexPath
            vc.piggy = self.categories?[exploreIndexPath.section-2].piggies?[exploreIndexPath.row]
        }
    }
    
    func reloadPiggies() {
        NotificationController.shared.showLoadingIndicator(view: self.view)
        APIClient.getExplore { (error, banners, categories) in
            NotificationController.shared.removeLoadingIndicator()
            guard error == nil else {
                //logout
                return
            }
            self.banners = banners
            self.categories = categories
            self.tableView.reloadData()
        }
    }
}



extension ExploreViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        var numberOfSections = 1
        if self.banners != nil {
            numberOfSections = numberOfSections + 1
        }
        if self.categories != nil {
            numberOfSections = numberOfSections + (self.categories?.count)!
        }
        return numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "headerCell")!
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell") as! CategoryCell
            cell.setCollectionViewDataSourceDelegate(dataSourceDelegate: self, forSection: indexPath.section)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 170
        default:
            return 160
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0,1:
            return 0
        default:
            return 120
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let  categoryHeaderCell = tableView.dequeueReusableCell(withIdentifier: "categoryHeaderCell") as! CategoryHeaderCell
        categoryHeaderCell.titleLabel.text = self.categories?[section-2].title!
        categoryHeaderCell.aboutLabel.text = self.categories?[section-2].about!
        return categoryHeaderCell
    }
}




extension ExploreViewController: UITableViewDelegate {
    
}



extension ExploreViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView.tag {
        case 1:
            return (self.banners?.count)!
        case 2:
            return (self.categories?[0].piggies!.count)!
        case 3:
            return (self.categories?[1].piggies!.count)!
        default:
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView.tag {
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "bannerCell", for: indexPath) as! BannerCell
            cell.bannerPhoto.image = self.banners![indexPath.row].image!
            return cell
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryItemCell", for: indexPath) as!
            CategoryItemCell
            cell.piggyImageView.image(image: (self.categories?[0].piggies?[indexPath.row].image)!, withType: .personal)
            cell.titleLabel.text = self.categories?[collectionView.tag-2].piggies?[indexPath.row].title
            return cell
        case 3:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryItemCell", for: indexPath) as! CategoryItemCell
            cell.piggyImageView.image(image: (self.categories?[1].piggies?[indexPath.row].image)!, withType: .event)
            cell.titleLabel.text = self.categories?[collectionView.tag-2].piggies?[indexPath.row].title
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
}



extension ExploreViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let exploreIndexPath = IndexPath(row: indexPath.row, section: collectionView.tag)
        self.performSegue(withIdentifier: "ToPublicPiggyVC", sender: exploreIndexPath)
    }
}



extension ExploreViewController: UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView.tag {
        case 1:
            return CGSize(width: UIScreen.main.bounds.size.width - 50, height: collectionView.frame.size.height)
        default:
            return CGSize(width: 100, height: 130)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if collectionView.tag > 1 {
            return UIEdgeInsets(top: 0, left: 100, bottom: 0, right: 0)
        }
        return UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 0)
    }
}



extension ExploreViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return CoverPresentAnimationController()
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return CoverDismissAnimationController()
    }
}

