//
//  SignupViewController.swift
//  AngelHackRio
//
//  Created by Jean Paul Marinho on 25/06/16.
//  Copyright © 2016 Jean Paul Marinho. All rights reserved.
//

import UIKit

class SignupViewController: UIViewController {

    @IBOutlet weak var topImageView: UIImageView!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nextButton: UIButton!
    var signupFieldsArray: [String] = []

    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.register(UINib(nibName: "SignupIconTableViewCell", bundle: nil), forCellReuseIdentifier: "CellIcon")
        self.tableView.register(UINib(nibName: "SignupLabelTableViewCell", bundle: nil), forCellReuseIdentifier: "CellLabel")
        self.tableView.register(UINib(nibName: "SignupTextViewTableViewCell", bundle: nil), forCellReuseIdentifier: "CellTextView")
        let path = Bundle.main().pathForResource("SignupFields", ofType: "plist")
        self.signupFieldsArray = NSArray(contentsOfFile: path!) as! [String]
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
        self.nextButton.layer.cornerRadius = self.nextButton.frame.size.height/2
    }
    
    @IBAction func nextButtonPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "toGuideVC", sender: nil)
    }
}



extension SignupViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.signupFieldsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var reuseIdentifier = ""
        let field = signupFieldsArray[indexPath.row]
        let value = User.sharedInstance.value(forKey: field.lowercased())
        switch indexPath.row {
        case 0:
            reuseIdentifier = "CellIcon"
            let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? SignupIconTableViewCell
            let typeImage: UIImage? = UIImage(named: field)
            cell?.typeImageView.image = typeImage
            cell?.inputTextField.text = value as? String
            return cell!
        case 1:
            reuseIdentifier = "CellIcon"
            let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? SignupIconTableViewCell
            let typeImage: UIImage? = UIImage(named: field)
            cell?.typeImageView.image = typeImage
            var valueText = ""
            for element in value as! [String] {
                valueText = valueText + "\(element),"
            }
            cell?.inputTextField.text = valueText
            return cell!
        case 2:
            reuseIdentifier = "CellTextView"
            let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? SignupTextViewTableViewCell
            cell?.titleLabel.text = field
            cell?.inputTextView.text = value as? String
            return cell!
        default:
            return UITableViewCell()
        }
    }
}



extension SignupViewController: UITableViewDelegate {
    
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
