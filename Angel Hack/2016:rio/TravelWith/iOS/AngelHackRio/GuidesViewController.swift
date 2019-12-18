//
//  RootViewController.swift
//  AngelHackRio
//
//  Created by Jean Paul Marinho on 25/06/16.
//  Copyright © 2016 Jean Paul Marinho. All rights reserved.
//

import UIKit

class GuidesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var backButton: UIButton!
    var guidesArray: [Guide] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.register(UINib(nibName: "GuideTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
        APIClient.sharedInstance.guides { (success, guidesArray) in
            if success {
                self.guidesArray = guidesArray!
                DispatchQueue.main.sync(execute: {
                    self.tableView.reloadData()
                    })
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let backButtonImage = UIImage(named: "image-back")
        backButtonImage?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        self.backButton.setImage(backButtonImage, for: [])
        self.backButton.tintColor = UIColor.lightGray()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: AnyObject?) {
        let vc = segue.destinationViewController as? GuideDetailViewController
        let indexPath = sender as! IndexPath
        let guide = self.guidesArray[indexPath.section]
        vc?.guide = guide
        vc?.photoImage = (self.tableView.cellForRow(at: indexPath) as! GuideTableViewCell).photoImageView.image
        vc?.topImage = (self.tableView.cellForRow(at: indexPath) as! GuideTableViewCell).graphicView.backgroundImage
    }
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}



extension GuidesViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.guidesArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? GuideTableViewCell
        let guide = self.guidesArray[indexPath.section]
        cell?.nameLabel.text = guide.name!
        cell?.placeLabel.text = guide.place?.baseDescription!
        APIClient.image(url: guide.photoURL!) { (success, image) in
            if success {
                DispatchQueue.main.sync(execute: {
                    cell?.photoImageView.image = image
                    cell?.photoImageView.setNeedsDisplay()
                })
            }
        }
        APIClient.image(url: guide.backgroundPhoto!) { (success, image) in
            if success {
                DispatchQueue.main.sync(execute: {
                    cell?.graphicView.backgroundImage = image
                    cell?.graphicView.setNeedsDisplay()
                })
            }
        }
        cell?.starValueLabel.text = "\(guide.stars!)"
        cell?.exploreValueLabel.text = "\(guide.experiences!)"
        return cell!
    }
}



extension GuidesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "toGuidesDetailVC", sender: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 5
    }
    
}
