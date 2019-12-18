//
//  InfluencerViewController.swift
//  JKIguatemi
//
//  Created by Jean Paul Marinho on 22/09/18.
//  Copyright © 2018 aKANJ. All rights reserved.
//

import UIKit
import ANLoader

class InfluencerViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    @IBOutlet var proceedView: UIView!
    @IBOutlet var influencerNameLabel: UILabel!
    @IBOutlet var influencerHeroImageView: UIImageView!
    var influencerName: String! {
        didSet {
            fetchScreen()
        }
    }
    var influencer: Influencer?
    var selectedURLs = [URL]()
    var selectedImages = [UIImage]()
    var imagesSentCount = 0
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.view.backgroundColor = UIColor.clear
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! BroadcastViewController
        vc.imagesURL = selectedURLs
        vc.images = selectedImages
        vc.influencerName = influencerName
    }
    
    func fetchScreen() {
        ANLoader.showLoading()
        APIClient.getInfluencerDetail(with: influencerName) { (influencer) in
            self.influencer = influencer.value
            self.updateScreen()
        }
    }
    
    func updateScreen() {
        influencerNameLabel.text = influencer?.name
        influencerHeroImageView.downloaded(from: (influencer?.imageHero)!)
        tableView.reloadData()
    }
    
    @IBAction func broadcastPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "toBroadcastVC", sender: nil)
    }
}



extension InfluencerViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard influencer != nil else {
            return 0
        }
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "suggestionCell") as! InfluencerStyleCell
            cell.delegate = self
            cell.looks = (influencer?.looks)!
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "otherCell")
            return cell!
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 300
        default:
            return 200
        }
    }
}



extension InfluencerViewController: InfluencerStyleCellDelegate {
    
    func itemSelected(image: UIImage, index: Int) {
        if selectedImages.count == 0 {
            proceedView.frame = CGRect(x: 0, y: view.frame.height, width: view.frame.width, height: 100)
            view.addSubview(proceedView)
            UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseInOut, animations: {
                self.proceedView.frame = CGRect(x: 0, y: self.view.frame.height-100, width: self.view.frame.width, height: 100)
            }, completion: { success in
            })
        }
        let look = URL(string: (influencer?.looks[index])!)
        selectedURLs.append(look!)
        selectedImages.append(image)
    }
}
