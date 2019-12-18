//
//  GuideDetailViewController.swift
//  AngelHackRio
//
//  Created by Jean Paul Marinho on 25/06/16.
//  Copyright © 2016 Jean Paul Marinho. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

class GuideDetailViewController: UIViewController {

    @IBOutlet weak var topImageView: UIImageView!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    var guide: Guide?
    var fieldsArray: [String] = []
    @IBOutlet weak var tableView: UITableView!
    var photoImage: UIImage?
    var topImage: UIImage?
    @IBOutlet weak var backButton: UIButton!
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.titleLabel.text = guide?.name!
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.register(UINib(nibName: "SignupIconTableViewCell", bundle: nil), forCellReuseIdentifier: "CellIcon")
        self.tableView.register(UINib(nibName: "SignupLabelTableViewCell", bundle: nil), forCellReuseIdentifier: "CellLabel")
        self.tableView.register(UINib(nibName: "SignupTextViewTableViewCell", bundle: nil), forCellReuseIdentifier: "CellTextView")
        let path = Bundle.main().pathForResource("SignupFields", ofType: "plist")
        self.fieldsArray = NSArray(contentsOfFile: path!) as! [String]
        self.tableView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.photoImageView.layer.cornerRadius = self.photoImageView.frame.size.height/2.0
        self.photoImageView.clipsToBounds = true
        self.photoImageView.layer.borderWidth = 3.0;
        self.photoImageView.layer.borderColor = UIColor.white().cgColor
        self.photoImageView.setNeedsDisplay()
        let filterView = UIView(frame: self.topImageView.frame)
        filterView.backgroundColor = UIColor(colorLiteralRed: 132/255.0, green: 220/255.0, blue: 244/255.0, alpha: 0.3)
        self.topImageView.addSubview(filterView)
        self.topImageView.setNeedsDisplay()
//        self.topImageView.image = guide.backgroundImage
        self.titleLabel.text = guide?.name!
        self.photoImageView.image = photoImage
        self.topImageView.image = topImage
        let backButtonImage = UIImage(named: "image-back")
        backButtonImage?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        self.backButton.setImage(backButtonImage, for: [])
        self.backButton.tintColor = UIColor.white()
    }
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func requestButtonPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "toTourVC", sender: nil)
    }
    
    @IBAction func videoButtonPressed(_ sender: UIButton) {
        let moviePath = Bundle.main().pathForResource("GuideVideo", ofType: "mp4")
        if let path = moviePath {
            let url = NSURL.fileURL(withPath: path)
            let player = AVPlayer(url: url)
            let playerViewController = AVPlayerViewController()
            playerViewController.player = player
            self.present(playerViewController, animated: true) {
                if let validPlayer = playerViewController.player {
                    validPlayer.play()
                }
            }
        }
    }
}



extension GuideDetailViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.fieldsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var reuseIdentifier = ""
        let field = fieldsArray[indexPath.row]
        switch indexPath.row {
        case 0:
            reuseIdentifier = "CellIcon"
            let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? SignupIconTableViewCell
            let typeImage: UIImage? = UIImage(named: field)
            cell?.typeImageView.image = typeImage
            cell?.inputTextField.text = guide?.place?.baseDescription!

            return cell!
        case 1:
            reuseIdentifier = "CellIcon"
            let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? SignupIconTableViewCell
            let typeImage: UIImage? = UIImage(named: field)
            cell?.typeImageView.image = typeImage
            var valueText = ""
//            for element in (guide?.language)! {
//                valueText = valueText + "\(element),"
//            }
            cell?.inputTextField.text = "Portuguese and English"
            return cell!
        case 2:
            reuseIdentifier = "CellTextView"
            let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? SignupTextViewTableViewCell
            cell?.titleLabel.text = field
            cell?.inputTextView.text = guide?.about!

            return cell!
        default:
            return UITableViewCell()
        }
    }
}



extension GuideDetailViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0,1:
            return 44
        case 2:
            return 130
        default:
            return 0
        }
    }
}
