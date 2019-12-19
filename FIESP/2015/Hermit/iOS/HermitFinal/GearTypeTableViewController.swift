//
//  GearTypeTableViewController.swift
//  
//
//  Created by Jean Paul dos Santos Marinho on 22/08/15.
//
//

import UIKit
import Bolts
import Parse

class GearTypeTableViewController: UITableViewController {
    
    @IBOutlet weak var doneBarButton: UIBarButtonItem!
    var selectedCardQuantity = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        doneBarButton.isEnabled = false
        
        var query = PFQuery(className: "GearCategory")
        gearCategories = []
        var fetchResults = [PFObject]()
        
        query.findObjectsInBackground(block: {(objects, error) in
            if (error != nil) {
                print("error " + error!.localizedDescription)
            }
            else {
                fetchResults = (objects as! [PFObject])
                for fetchResult in fetchResults {
                    var gearCategory: GearCategory = GearCategory(name: fetchResult.object(forKey: "name") as! String)
                    (fetchResult.object(forKey: "imageOff") as! PFFileObject).getDataInBackground(block: {(result, error) in
                        if (error != nil) {
                            print("error " + error!.localizedDescription)
                        }
                        else {
                            gearCategory.imageOff = UIImage(data: result!)
                        }
                        self.tableView.reloadData()
                    })
                    (fetchResult.object(forKey: "imageOn") as! PFFileObject).getDataInBackground(block: {(result, error) in
                        if (error != nil) {
                            print("error " + error!.localizedDescription)
                        }
                        else {
                            gearCategory.imageOn = UIImage(data: result!)
                        }
                        self.tableView.reloadData()
                    })
                    gearCategories.append(gearCategory)
                }
            }
        })
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        var tbView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.width))
        tbView.backgroundColor = UIColor.white
        tableView.backgroundView = tbView
        
        let backItem = UIBarButtonItem(title: "Equipamentos", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backItem
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var vc = segue.destination as! SwimmerListTableViewController
    }
    
    @IBAction func doneBarButtonPressed(sender: UIBarButtonItem) {
        performSegue(withIdentifier: "pushGearList", sender: nil)
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return gearCategories.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "card", for: indexPath) as! GearTypeTableViewCell
        
        //cell.putCardImage(UIImage(named: places[indexPath.section])!)
        if (gearCategories[indexPath.section].imageOff != nil) {
            cell.putCardImage(cardImage: gearCategories[indexPath.section].imageOff!)
        }
        return cell
    }
    
    // MARK: - Table view delegate
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var cell = tableView.cellForRow(at: indexPath as IndexPath) as! GearTypeTableViewCell
        if cell.selectedCard == false {
            cell.selectedCard = true
            cell.cardImage.image = gearCategories[indexPath.section].imageOn
            selectedCardQuantity += 1
        }
        else {
            cell.selectedCard = false
            cell.cardImage.image = gearCategories[indexPath.section].imageOff
            selectedCardQuantity -= 1
        }
        
        if selectedCardQuantity > 0 {
            doneBarButton.isEnabled = true
            doneBarButton.tintColor = UIColor.yellow
        }
        else if selectedCardQuantity == 0 {
            doneBarButton.isEnabled = false
        }
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = UIColor.white

    }
}
