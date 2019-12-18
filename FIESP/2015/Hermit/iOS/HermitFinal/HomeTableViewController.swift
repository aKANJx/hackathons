//
//  HomeTableViewController.swift
//  Hermit
//
//  Created by Jean Paul dos Santos Marinho on 22/08/15.
//  Copyright © 2015 Jean Paul Marinho. All rights reserved.
//

import UIKit
import Parse

class HomeTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var nav = self.navigationController?.navigationBar
        // 2
        nav?.barStyle = UIBarStyle.Black
        nav?.tintColor = UIColor.yellowColor()
        // 3
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        imageView.contentMode = .ScaleAspectFit
        // 4
        let image = UIImage(named: "Logo")
        imageView.image = image
        // 5
        navigationItem.titleView = imageView
        
        
        let notFirstLaunch = NSUserDefaults.standardUserDefaults().boolForKey("notFirstLaunch")
        if !notFirstLaunch  {
            let vc = storyboard?.instantiateViewControllerWithIdentifier("firstLaunchViewController") as! FirstLaunchViewController
            presentViewController(vc, animated: true, completion: nil)
            NSUserDefaults.standardUserDefaults().setBool(true, forKey: "notFirstLaunch")
        }
        
        var query = PFQuery(className: "Place")
        places = []
        var fetchResults = [PFObject]()
        
        query.findObjectsInBackgroundWithBlock({(NSArray objects, NSError error) in
            if (error != nil) {
                println("error " + error!.localizedDescription)
            }
            else {
                fetchResults = (objects as! [PFObject])
                for fetchResult in fetchResults {
                    var place: Place = Place(name: fetchResult.objectForKey("name") as! String)
                    (fetchResult.objectForKey("image") as! PFFile).getDataInBackgroundWithBlock({(NSData result, NSError error) in
                    if (error != nil) {
                    println("error " + error!.localizedDescription)
                    }
                    else {
                    place.image = UIImage(data: result!)
                    }
                        self.tableView.reloadData()
                    })
                    places.append(place)
                }
            }
        })
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var vc = segue.destinationViewController as! GearTypeTableViewController
        vc.title = currentPlaceSelected.name!
        
    }

// MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return places.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("card", forIndexPath: indexPath) as! HomeTableViewCell
        
        if (places[indexPath.section].image != nil) {
            cell.putCardImage(places[indexPath.section].image!)
        }
        return cell
    }

    
// MARK: - Table view delegate

    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 250
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 1
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var cell = tableView.cellForRowAtIndexPath(indexPath) as! HomeTableViewCell
        currentPlaceSelectedIndex = indexPath.section
        
        performSegueWithIdentifier("pushGearType", sender: nil)
    }
    
    override func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = UIColor.whiteColor()
    }
}
