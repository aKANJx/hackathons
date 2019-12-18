//
//  HomeCell.swift
//  HackAmericas
//
//  Created by jeanpaul on 12/1/18.
//  Copyright © 2018 Jean Paul Marinho. All rights reserved.
//

import UIKit

class HomeCell: UITableViewCell {

    @IBOutlet var collectionView: UICollectionView!
    var scheduleHeadersTitle = ["T\no\nd\na\ny", "", "N\ne\nx\nt"]
   var schedules = [Schedule]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 12
        layer.borderColor = UIColor.groupTableViewBackground.cgColor
        layer.borderWidth = 1
        collectionView.dataSource = self
        collectionView.delegate = self
        loadSchedules()
    }
    
    func loadSchedules() {
        let schedule0 = Schedule(pickupAddress: "Rua Maria Antônia 456", destinationAddress: "Metrô República", price: 2.8, imageName: "image-map0", hourType: 1)
        let schedule1 = Schedule(pickupAddress: "Rua Piauí 23", destinationAddress: "Cultura Inglesa", price: 3.2, imageName: "image-map1", hourType: 0)
        let schedule2 = Schedule(pickupAddress: "Rua Itambé 54", destinationAddress: "Parque Ibirapuera", price: 3.0, imageName: "image-map2", hourType: 0)
        let schedule3 = Schedule(pickupAddress: "Metrô República", destinationAddress: "Colégio ETAPA", price: 3.5, imageName: "image-map3", hourType: 2)
        schedules = [schedule1, schedule0, schedule2, schedule2, schedule3]
        collectionView.reloadData()
    }
}



extension HomeCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return schedules.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.row {
        case 0,2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ScheduleHeaderCell", for: indexPath) as! ScheduleHeaderCell
            cell.titleLabel.text = scheduleHeadersTitle[indexPath.row]
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ScheduleCell", for: indexPath) as! ScheduleCell
            let schedule = schedules[indexPath.row]
            cell.pickupAddressLabel.text = schedule.pickupAddress
            cell.destinationAddressLabel.text = schedule.destinationAddress
            cell.imageView.image = UIImage(named: schedule.imageName)
            cell.priceLabel.text = "\(schedule.price)0"
            cell.hourTypeView.image = UIImage(named: "image-hour\(schedule.hourType)")
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.row {
        case 0,2:
            return CGSize(width: 40, height: 320)
        default:
            return CGSize(width: 220, height: 320)
        }
    }
}
