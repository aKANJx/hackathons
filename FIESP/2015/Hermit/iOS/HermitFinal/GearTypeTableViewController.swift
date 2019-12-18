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
        
        doneBarButton.enabled = false
        
        var query = PFQuery(className: "GearCategory")
        gearCategories = []
        var fetchResults = [PFObject]()
        
        query.findObjectsInBackgroundWithBlock({(NSArray objects, NSError error) in
            if (error != nil) {
                println("error " + error!.localizedDescription)
            }
            else {
                fetchResults = (objects as! [PFObject])
                for fetchResult in fetchResults {
                    var gearCategory: GearCategory = GearCategory(name: fetchResult.objectForKey("name") as! String)
                    (fetchResult.objectForKey("imageOff") as! PFFile).getDataInBackgroundWithBlock({(NSData result, NSError error) in
                        if (error != nil) {
                            println("error " + error!.localizedDescription)
                        }
                        else {
                            gearCategory.imageOff = UIImage(data: result!)
                        }
                        self.tableView.reloadData()
                    })
                    (fetchResult.objectForKey("imageOn") as! PFFile).getDataInBackgroundWithBlock({(NSData result, NSError error) in
                        if (error != nil) {
                            println("error " + error!.localizedDescription)
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
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        var tbView = UIView(frame: CGRectMake(0, 0, self.view.bounds.width, self.view.bounds.width))
        tbView.backgroundColor = UIColor.whiteColor()
        tableView.backgroundView = tbView
        
        let backItem = UIBarButtonItem(title: "Equipamentos", style: UIBarButtonItemStyle.Plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backItem
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var vc = segue.destinationViewController as! SwimmerListTableViewController
        //vc.title = currentPlaceTitle
        
    }
    
    @IBAction func doneBarButtonPressed(sender: UIBarButtonItem) {
        performSegueWithIdentifier("pushGearList", sender: nil)
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return gearCategories.count
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("card", forIndexPath: indexPath) as! GearTypeTableViewCell
        
        //cell.putCardImage(UIImage(named: places[indexPath.section])!)
        if (gearCategories[indexPath.section].imageOff != nil) {
            cell.putCardImage(gearCategories[indexPath.section].imageOff!)
        }
        return cell
    }
    
    
    // MARK: - Table view delegate
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 1
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var cell = tableView.cellForRowAtIndexPath(indexPath) as! GearTypeTableViewCell
        if cell.selectedCard == false {
            cell.selectedCard = true
            cell.cardImage.image = gearCategories[indexPath.section].imageOn
            selectedCardQuantity++
        }
        else {
            cell.selectedCard = false
            cell.cardImage.image = gearCategories[indexPath.section].imageOff
            selectedCardQuantity--
        }
        
        if selectedCardQuantity > 0 {
            doneBarButton.enabled = true
            doneBarButton.tintColor = UIColor.yellowColor()
        }
        else if selectedCardQuantity == 0 {
            doneBarButton.enabled = false
        }
    }

    override func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = UIColor.whiteColor()
    }
}
