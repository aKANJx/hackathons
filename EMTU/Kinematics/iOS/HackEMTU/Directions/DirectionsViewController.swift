//
//  ViewController.swift
//  HackEMTU
//
//  Created by Jean Paul Marinho on 4/7/18.
//  Copyright © 2018 aKANJ. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class DirectionsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var homeResponse = HomeResponse()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "WelcomeVC")
        self.present(vc!, animated: true, completion: nil)
        APIClient.getHome { (homeResponse) in
            self.homeResponse = homeResponse
            self.tableView.reloadData()
        }
        self.tableView.contentInset = UIEdgeInsets(top: 15, left: 0, bottom: 0, right: 0)
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.delegate = self
        self.navigationItem.searchController = searchController
        self.navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? PreviewRouteViewController {
            destinationVC.address = sender as! String
        }
    }
}



extension DirectionsViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.performSegue(withIdentifier: "ToPreviewRouteVC", sender: searchBar.text!)
        self.navigationItem.searchController?.dismiss(animated: true, completion: nil)
    }
}


extension DirectionsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 2
        }
        return (self.homeResponse.history.count)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let header = tableView.dequeueReusableCell(withIdentifier: "HeaderCell") as! DirectionsHeaderCell
            switch indexPath.section {
            case 0:
                header.titleLabel.text = "Latest Keepers"
            case 1:
                header.titleLabel.text = "Favorites"
            default:
                header.titleLabel.text = "History"
            }
            return header
        }
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "LatestKeepersCell") as! LatestKeepersCell
            cell.collectionView.reloadData()
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "FavoritesCell") as! FavoritesCell
            switch indexPath.row {
            case 1:
                cell.iconImageView.image = UIImage(named: "icon-home")
                cell.titleLabel.text = "Home"
            case 2:
                cell.iconImageView.image = UIImage(named: "icon-work")
                cell.titleLabel.text = "Work"
            default:
                cell.iconImageView.image = UIImage(named: "icon-love")
                cell.titleLabel.text = "Girlfriend"
            }
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryCell")!
            cell.textLabel?.text = self.homeResponse.history[indexPath.row]
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 50
        }
        switch indexPath.section {
        case 0:
            return 230
        default:
            return 58
        }
    }
}



extension DirectionsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (self.homeResponse.keepers.count)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! LatestKeepersItemCell
        let item = self.homeResponse.keepers[indexPath.row]
        cell.addressLabel.text = item.address
        cell.availableLabel.text = item.available
        let downloadURL = URL(string: "\(APIClient.domainURL)\(item.url)")!
        cell.coverImageView.af_setImage(withURL: downloadURL)
        return cell
    }
}
