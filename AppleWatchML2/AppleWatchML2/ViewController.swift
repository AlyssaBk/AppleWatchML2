//
//  ViewController.swift
//  AppleWatchML2
//
//  Created by Samuel Bellerose on 2015-11-21.
//  Copyright © 2015 Samuel Bellerose. All rights reserved.
//

import UIKit
import MBProgressHUD
import Alamofire

import SafariServices

class ViewController: UITableViewController {
    
    var requestUtilityObject = RequestUtility()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        let loadingNotification = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        loadingNotification.mode = MBProgressHUDMode.Indeterminate
        loadingNotification.labelText = "Loading"
        
        requestUtilityObject.fetchData("All") { (Int) -> Void in
            loadingNotification.hide(true)
            self.tableView.reloadData()
        }
        
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return requestUtilityObject.getProjectsList().count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("mainCell", forIndexPath: indexPath)
        let project = requestUtilityObject.getProjectsList()[indexPath.row]
        cell.textLabel?.text = project.name
        
        let projectLink = requestUtilityObject.getProjectsList()[indexPath.row].link
        
        if(((projectLink?.lowercaseString .hasPrefix("http"))) != false) {
            cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        }
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let projectLink = requestUtilityObject.getProjectsList()[indexPath.row].link
        
        if(((projectLink?.lowercaseString .hasPrefix("http"))) != false) {
            let svc = SFSafariViewController(URL: NSURL(string: projectLink!)!)
            self.presentViewController(svc, animated: true, completion: nil)
        }
        
        

        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }

}

