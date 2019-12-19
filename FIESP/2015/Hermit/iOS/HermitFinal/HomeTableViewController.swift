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
        nav?.barStyle = UIBarStyle.black
        nav?.tintColor = UIColor.yellow
        // 3
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        imageView.contentMode = .scaleAspectFit
        // 4
        let image = UIImage(named: "Logo")
        imageView.image = image
        // 5
        navigationItem.titleView = imageView
        
        
        let notFirstLaunch = UserDefaults.standard.bool(forKey: "notFirstLaunch")
        if !notFirstLaunch  {
            let vc = storyboard?.instantiateViewController(withIdentifier: "firstLaunchViewController") as! FirstLaunchViewController
            present(vc, animated: true, completion: nil)
            UserDefaults.standard.set(true, forKey: "notFirstLaunch")
        }
        
        var query = PFQuery(className: "Place")
        places = []
        var fetchResults = [PFObject]()
        
        query.findObjectsInBackground(block: {(objects, error) in
            if (error != nil) {
                print("error " + error!.localizedDescription)
            }
            else {
                fetchResults = (objects as! [PFObject])
                for fetchResult in fetchResults {
                    var place: Place = Place(name: fetchResult.object(forKey: "name") as! String)
                    (fetchResult.object(forKey: "image") as! PFFileObject).getDataInBackground(block: {(result, error) in
                        if (error != nil) {
                            print("error " + error!.localizedDescription)
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! GearTypeTableViewController
        vc.title = currentPlaceSelected.name!
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return places.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "card", for: indexPath as IndexPath) as! HomeTableViewCell
        
        if (places[indexPath.section].image != nil) {
            cell.putCardImage(cardImage: places[indexPath.section].image!)
        }
        return cell
    }
    
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        _ = tableView.cellForRow(at: indexPath as IndexPath) as! HomeTableViewCell
        currentPlaceSelectedIndex = indexPath.section
        performSegue(withIdentifier: "pushGearType", sender: nil)
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = UIColor.white
    }
}
