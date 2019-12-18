//
//  PiggysCVViewController.swift
//  Piggy
//
//  Created by Jean Paul Marinho on 15/01/17.
//  Copyright © 2017 aKANJ. All rights reserved.
//

import UIKit
import Hero

class PiggiesViewController: UIViewController {

    
    @IBOutlet weak var collectionView: UICollectionView!
    var categories: [Category]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.edgesForExtendedLayout = .all
        self.collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 60, right: 0)
        self.collectionView.register(UINib(nibName: "PiggyCell", bundle: nil), forCellWithReuseIdentifier: "piggyCell")
        self.collectionView.register(UINib(nibName: "PHeaderSection", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "headerSection")
        self.collectionView.register(UINib(nibName: "PFooterSection", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: "footerSection")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.reloadPiggies()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToPiggyVC" {
            let vc = segue.destination as! PiggyViewController
            vc.transitioningDelegate = self
            let indexPath = (sender as! IndexPath)
            vc.piggy = self.categories?[indexPath.section-1].piggies?[indexPath.row]
        }
    }
    
    @IBAction func handleLongGesture(_ sender: UILongPressGestureRecognizer) {
        switch(sender.state) {
        case .began:
            guard let selectedIndexPath = self.collectionView.indexPathForItem(at: sender.location(in: self.collectionView)) else {
                break
            }
            let cell = collectionView.cellForItem(at: selectedIndexPath)
            UIView.animate(withDuration: 0.2, animations: {
                cell?.transform = CGAffineTransform(scaleX: 1.2,y: 1.2)
            }, completion: { (success) in
                UIView.animate(withDuration: 0.2) {
                    cell?.transform = CGAffineTransform.identity
                }
            })
            self.collectionView.beginInteractiveMovementForItem(at: selectedIndexPath)
        case .changed:
            let cell = self.collectionView.cellForItem(at: IndexPath(row: 0, section: 1))
            if sender.location(in: self.collectionView).y <= ((cell?.frame.origin.y)! + (cell?.frame.size.height)!) {
                sender.cancel()
                self.changeActivePiggy(indexPath: self.collectionView.indexPathForItem(at: sender.location(in: self.collectionView))!)
            }
            self.collectionView.updateInteractiveMovementTargetPosition(sender.location(in: sender.view!))
        case .ended:
            collectionView.endInteractiveMovement()
        default:
            collectionView.cancelInteractiveMovement()
        }
    }
    
    func changeActivePiggy(indexPath: IndexPath) {
        NotificationController.shared.showLoadingIndicator(view: self.view)
        APIClient.updateActivePiggy(alias: self.categories![indexPath.section].piggies![indexPath.row].alias!) { (error) in
            NotificationController.shared.removeLoadingIndicator()
            guard error == nil else {
                self.collectionView.reloadData()
                return
            }
            self.reloadPiggies()
        }

    }
    
    func reloadPiggies() {
        NotificationController.shared.showLoadingIndicator(view: self.view)
        APIClient.getPiggies { (error, categories) in
            NotificationController.shared.removeLoadingIndicator()
            guard error == nil else {
                //logout
                return
            }
            self.categories = categories
            self.collectionView.reloadData()
        }
    }
}



extension PiggiesViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        guard self.categories != nil else {
            return 1
        }
        return 1 + self.categories!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0,1:
            return 1
        default:
            return self.categories![section-1].piggies!.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "navigationHeaderCell", for: indexPath) as! PNavigationHeaderCell
            cell.delegate = self
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "activeCell", for: indexPath) as! PActiveCell
            cell.delegate = self
            let piggy = self.categories?[indexPath.section-1].piggies?[indexPath.row]
            guard  piggy != nil else {
                return UICollectionViewCell()
            }
            let imageData = UserDefaults.standard.object(forKey: (piggy?.alias!)!)
            piggy?.image = UIImage(data: imageData as! Data)
            cell.piggyImageView.image(image: piggy!.image!, withType: piggy!.type!)
            cell.titleLabel.text = piggy!.title
            if cell.titleLabel.text == "aKANJ" {
                cell.titleLabel.text = "Jean Paul Marinho"
            }
            cell.aliasLabel.text = piggy!.alias
            cell.seedersLabel.text = "\(piggy!.seeders!)"
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "piggyCell", for: indexPath) as! PiggyCell
            cell.delegate = self
            let piggy = self.categories?[indexPath.section-1].piggies?[indexPath.row]
            guard  piggy != nil else {
                return UICollectionViewCell()
            }
            let imageData = UserDefaults.standard.object(forKey: (piggy?.alias!)!)
            piggy?.image = UIImage(data: imageData as! Data)
            cell.piggyImageView.image(image: piggy!.image!, withType: piggy!.type!)
            cell.piggyImageView.image(image: piggy!.image!, withType: piggy!.type!)
            cell.titleLabel.text = piggy!.title
            if cell.titleLabel.text == "aKANJ" {
                cell.titleLabel.text = "Jean Paul Marinho"
            }
            cell.aliasLabel.text = piggy!.alias
            cell.seedersLabel.text = "\(piggy!.seeders!)"
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == "UICollectionElementKindSectionHeader" {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "headerSection", for: indexPath) as! PHeaderSection
            guard indexPath.section > 1 else {
                return header
            }
            header.titleLabel.text = self.categories?[indexPath.section-1].title
            return header
        }
        else {
            return collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionFooter, withReuseIdentifier: "footerSection", for: indexPath)
        }
    }
}



extension PiggiesViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            return
        default:
            self.performSegue(withIdentifier: "ToPiggyVC", sender: indexPath)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        guard indexPath.section > 1 else {
            return false
        }
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
    }
}



extension PiggiesViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.section {
        case 0:
            return CGSize(width: 375, height: 133)
        case 1:
            return CGSize(width: 375, height: 278)
        default:
            return CGSize(width: 150, height: 165)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        switch section {
        case 0,1:
            return CGSize.zero
        default:
            return CGSize(width: 375, height: 64)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: 375, height: 3)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        guard section > 1 else {
            return UIEdgeInsets.zero
        }
        return UIEdgeInsets(top: 0, left: 30, bottom: 30, right: 30)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 30
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}



extension PiggiesViewController: PiggiesCellDelegate {
    
    func createPressed(sender: UIButton) {
        self.performSegue(withIdentifier: "ToAddPiggyVC", sender: nil)
    }
    
    func settingsPressed(sender: UIButton) {
        UserDefaults.standard.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
        UserDefaults.standard.synchronize()
        //self.performSegue(withIdentifier: "ToSettingsVC", sender: nil)
    }
}



extension PiggiesViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return OverlayPresentAnimationController()
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return OverlayDismissAnimationController()
    }
}
