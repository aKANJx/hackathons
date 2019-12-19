//
//  GearListTableViewController.swift
//  
//
//  Created by Jean Paul dos Santos Marinho on 23/08/15.
//
//

import UIKit

class GearListTableViewController: UITableViewController {
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let backItem = UIBarButtonItem(title: "Usuários", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backItem
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          let cell = tableView.dequeueReusableCell(withIdentifier: "card", for: indexPath as IndexPath) as! GearListTableViewCell
              var gear = swimmers[0].gears
              var gearObjectLast = gear?.removeLast()
              cell.gearImageView?.image = gearObjectLast?.image
              cell.title.text = gearObjectLast?.title
              cell.subtitle.text = gearObjectLast?.subtitle
              cell.descriptionTextView.text = gearObjectLast?.description!
              cell.price.text = gearObjectLast?.price
              
              var evaluation = gearObjectLast!.evaluationSum! / gearObjectLast!.evaluationQuantity!
              
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
              return cell
    }
    
    
    // MARK: - Table view delegate
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 420
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = UIColor.white
    }
}
