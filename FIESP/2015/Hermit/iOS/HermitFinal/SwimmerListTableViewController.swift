//
//  SwimmerListTableViewController.swift
//  
//
//  Created by Jean Paul dos Santos Marinho on 22/08/15.
//
//

import UIKit
import Parse
import Bolts

class SwimmerListTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //UserLocation.sharedInstance.startUpdatingLocation()
        var query = PFQuery(className: "Swimmer")
        swimmers = []
        query.orderByDescending("evaluationSum")
        query.whereKey("place", containsString: currentPlaceSelected.name!)
        var fetchResults = [PFObject]()
        
        query.findObjectsInBackgroundWithBlock({(NSArray objects, NSError error) in
            if (error != nil) {
                println("error " + error!.localizedDescription)
            }
            else {
                fetchResults = (objects as! [PFObject])
                for fetchResult in fetchResults {
                    var swimmer: Swimmer = Swimmer(name: fetchResult.objectForKey("name") as! String)
                    swimmers.append(swimmer)
                    (fetchResult.objectForKey("photo") as! PFFile).getDataInBackgroundWithBlock({(NSData result, NSError error) in
                        if (error != nil) {
                            println("error " + error!.localizedDescription)
                        }
                        else {
                            swimmer.photo = UIImage(data: result!)
                            self.tableView.reloadData()
                        }
                    })
                    swimmer.swimmerDescription = fetchResult.objectForKey("description") as? String
                    swimmer.evaluationQuantity = fetchResult.objectForKey("evaluationQuantity") as? Int
                    swimmer.evaluationSum = fetchResult.objectForKey("evaluationSum") as? Int
                    var gears = (fetchResult.objectForKey("gears") as! [String])
                    var gearID = gears[0]
                    
                    var query = PFQuery(className:"Gear")
                    query.getObjectInBackgroundWithId(gearID) {
                        (gearObject: PFObject?, error: NSError?) -> Void in
                        if error == nil && gearObject != nil {
                            var gear = Gear(title: (gearObject?.objectForKey("title") as! String))
                            gear.subtitle = (gearObject?.objectForKey("subtitle") as! String)
                            gear.category = (gearObject?.objectForKey("category") as! String)
                            gear.description = (gearObject?.objectForKey("description") as! String)
                            gear.price = (gearObject?.objectForKey("price") as! String)
                            gear.evaluationSum = (gearObject?.objectForKey("evaluationSum") as! Int)
                            gear.evaluationQuantity = (gearObject?.objectForKey("evaluationQuantity") as! Int)


                            (gearObject!.objectForKey("image") as! PFFile).getDataInBackgroundWithBlock({(NSData result, NSError error) in
                                if (error != nil) {
                                    println("error " + error!.localizedDescription)
                                }
                                else {
                                    gear.image = UIImage(data: result!)
                                    self.tableView.reloadData()
                                }
                            })
                            swimmer.gears?.append(gear)
                            
                        } else {
                            println(error)
                        }
                    }
                }
            }
            //self.tableView.reloadData()
        })
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let backItem = UIBarButtonItem(title: "Equipamentos", style: UIBarButtonItemStyle.Plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backItem
    }
    
    func CreateProfessionalCollection(query: PFQuery) {
        
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return swimmers.count
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("card", forIndexPath: indexPath) as! SwimmerListTableViewCell
        let swimmer = swimmers[indexPath.section]
        
        if (swimmer.photo != nil) {
            cell.name.text = swimmer.name!
            cell.profilePhotoView.image = swimmer.photo!
            cell.profilePhotoView.setNeedsDisplay()
            cell.descriptionTextView.text = swimmer.swimmerDescription!
            
            var evaluation = swimmer.evaluationSum! / swimmer.evaluationQuantity!
            
            switch evaluation {
            case 1:
                cell.star0.image = UIImage(named: "Star-Filled")
            case 2:
                cell.star0.image = UIImage(named: "Star-Filled")
                cell.star1.image = UIImage(named: "Star-Filled")
            case 3:
                cell.star0.image = UIImage(named: "Star-Filled")
                cell.star1.image = UIImage(named: "Star-Filled")
                cell.star2.image = UIImage(named: "Star-Filled")
            case 4:
                cell.star0.image = UIImage(named: "Star-Filled")
                cell.star1.image = UIImage(named: "Star-Filled")
                cell.star2.image = UIImage(named: "Star-Filled")
                cell.star3.image = UIImage(named: "Star-Filled")

            case 5:
                cell.star0.image = UIImage(named: "Star-Filled")
                cell.star1.image = UIImage(named: "Star-Filled")
                cell.star2.image = UIImage(named: "Star-Filled")
                cell.star3.image = UIImage(named: "Star-Filled")
                cell.star4.image = UIImage(named: "Star-Filled")
            default:
                break
            }
        }
        return cell
    }
    
    
    // MARK: - Table view delegate
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 200
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var cell = tableView.cellForRowAtIndexPath(indexPath) as! SwimmerListTableViewCell
        currentSwimmerSelectedIndex = indexPath.section
        performSegueWithIdentifier("pushGearList", sender: nil)
    }
    
    override func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = UIColor.whiteColor()
    }
}
