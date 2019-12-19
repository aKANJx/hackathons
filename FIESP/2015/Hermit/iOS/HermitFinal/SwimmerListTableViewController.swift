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
        query.order(byDescending: "evaluationSum")
        query.whereKey("place", contains: currentPlaceSelected.name!)
        var fetchResults = [PFObject]()
        
        query.findObjectsInBackground(block: {(objects, error) in
            if (error != nil) {
                print("error " + error!.localizedDescription)
            }
            else {
                fetchResults = (objects as! [PFObject])
                for fetchResult in fetchResults {
                    var swimmer: Swimmer = Swimmer(name: fetchResult.object(forKey: "name") as! String)
                    swimmers.append(swimmer)
                    (fetchResult.object(forKey: "photo") as! PFFileObject).getDataInBackground(block: {(result, error) in
                        if (error != nil) {
                            print("error " + error!.localizedDescription)
                        }
                        else {
                            swimmer.photo = UIImage(data: result!)
                            self.tableView.reloadData()
                        }
                    })
                    swimmer.swimmerDescription = fetchResult.object(forKey: "description") as? String
                    swimmer.evaluationQuantity = fetchResult.object(forKey: "evaluationQuantity") as? Int
                    swimmer.evaluationSum = fetchResult.object(forKey: "evaluationSum") as? Int
                    var gears = (fetchResult.object(forKey: "gears") as! [String])
                    var gearID = gears[0]
                    
                    var query = PFQuery(className:"Gear")
                    query.getObjectInBackground(withId: gearID) { (gearObject, error) in
                        if error == nil && gearObject != nil {
                            var gear = Gear(title: (gearObject?.object(forKey: "title") as! String))
                            gear.subtitle = (gearObject?.object(forKey: "subtitle") as! String)
                            gear.category = (gearObject?.object(forKey: "category") as! String)
                            gear.description = (gearObject?.object(forKey: "description") as! String)
                            gear.price = (gearObject?.object(forKey: "price") as! String)
                            gear.evaluationSum = (gearObject?.object(forKey: "evaluationSum") as! Int)
                            gear.evaluationQuantity = (gearObject?.object(forKey: "evaluationQuantity") as! Int)
                            
                            
                            (gearObject!.object(forKey: "image") as! PFFileObject).getDataInBackground(block: {(result, error) in
                                if (error != nil) {
                                    print("error " + error!.localizedDescription)
                                }
                                else {
                                    gear.image = UIImage(data: result!)
                                    self.tableView.reloadData()
                                }
                            })
                            swimmer.gears?.append(gear)
                            
                        } else {
                            print(error)
                        }
                    }
                }
            }
            //self.tableView.reloadData()
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let backItem = UIBarButtonItem(title: "Equipamentos", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backItem
    }
    
    func CreateProfessionalCollection(query: PFQuery<PFObject>) {
        
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return swimmers.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "card", for: indexPath) as! SwimmerListTableViewCell
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
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        _ = tableView.cellForRow(at: indexPath as IndexPath) as! SwimmerListTableViewCell
        currentSwimmerSelectedIndex = indexPath.section
        performSegue(withIdentifier: "pushGearList", sender: nil)
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = UIColor.white
    }
    
}
