//
//  DriverViewController.swift
//  UberTutorial
//
//  Created by Chris Kong on 9/16/15.
//  Copyright © 2015 Chris Kong. All rights reserved.
//

import UIKit
import Parse

class DriverViewController: UITableViewController
{



  // MARK: - Table view data source

  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    // #warning Incomplete implementation, return the number of sections
    return 0
  }

  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // #warning Incomplete implementation, return the number of rows
    return 0
  }

  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    
    if segue.identifier == "driverLogout"
    {
      navigationController?.setNavigationBarHidden(navigationController?.navigationBarHidden == false, animated: false)
      PFUser.logOut()
    }
  }
 

}