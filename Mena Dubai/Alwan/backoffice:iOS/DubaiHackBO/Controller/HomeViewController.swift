//
//  HomeViewController.swift
//  DubaiHackBO
//
//  Created by Jean Paul Marinho on 20/04/18.
//  Copyright © 2018 aKANJ. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {


    @IBOutlet weak var tableView: UITableView!
    var stationsLine = [StationsLine]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.updateStationsData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! StationDetailViewController
        destinationVC.station = sender as! Station
    }
    
    func updateStationsData() {
        if let url = Bundle.main.url(forResource: "StationsData", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode([StationsLine].self, from: data)
                self.stationsLine = jsonData
                self.tableView.reloadData()
            } catch {
                print("error:\(error)")
            }
        }
    }
    
    func graphicUpdate(for cell: StationCell, color: UIColor) {
        cell.graphicLeftArmView.backgroundColor = color
        cell.graphicRightArmView.backgroundColor = color
        cell.graphicCenterView.backgroundColor = color
    }
}



extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.stationsLine.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StationsLineCell") as! StationsLineCell
        cell.collectionView.tag = indexPath.section
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 230
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerCell = tableView.dequeueReusableCell(withIdentifier: "StationsLineHeaderCell") as! StationLineHeaderCell
        headerCell.nameLabel.text = self.stationsLine[section].name
        return headerCell
    }
}



extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.stationsLine[collectionView.tag].stations.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StationCell", for: indexPath) as! StationCell
        let item = self.stationsLine[collectionView.tag].stations[indexPath.row]
        if indexPath.row == 0 {
            cell.graphicLeftArmView.isHidden = true
            cell.graphicRightArmView.isHidden = false
        }
        else if indexPath.row == self.stationsLine[collectionView.tag].stations.count-1 {
            cell.graphicLeftArmView.isHidden = false
            cell.graphicRightArmView.isHidden = true
        }
        else {
            cell.graphicLeftArmView.isHidden = false
            cell.graphicRightArmView.isHidden = false
        }
        if self.stationsLine[collectionView.tag].name == "Red" {
            self.graphicUpdate(for: cell, color: UIColor(red: 195/255.0, green: 39/255.0, blue: 43/255.0, alpha: 1.0))
        }
        else if self.stationsLine[collectionView.tag].name == "Green" {
            self.graphicUpdate(for: cell, color: UIColor(red: 91/255.0, green: 137/255.0, blue: 48/255.0, alpha: 1.0))
        }
        
        
        cell.nameLabel.text = "\(indexPath.row+1) - \(item.name)"
        cell.activeUsersLabel.text = "Active users: \(Int(arc4random_uniform(12))*24)"//"\(item.activeUsers)"
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "ToDetailStationVC", sender: self.stationsLine[collectionView.tag].stations[indexPath.row])
    }
}
