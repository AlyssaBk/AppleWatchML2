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

class ViewController: UITableViewController {
    
    var requestUtilityObject = RequestUtility()
    var editButtonSelected = false

    @IBAction func editButtonAction(sender: UIButton, forEvent event: UIEvent) {
        if(editButtonSelected == false){
            tableView.setEditing(true, animated: true)
            sender.setTitle("Cancel", forState: .Normal)
            editButtonSelected = true
        }
        else if(editButtonSelected == true){
            tableView.setEditing(false, animated: true)
            sender.setTitle("Edit", forState: .Normal)
            editButtonSelected = false
        }
    }
    
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
        cell.textLabel?.font = UIFont(name:"Avenir", size:11)
        return cell
    }
    
    override func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
        return .None
    }
    
    override func tableView(tableView: UITableView, shouldIndentWhileEditingRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }
    
    override func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
        var project = requestUtilityObject.getProjectsList()
        let movedObject = project[sourceIndexPath.row]
        project.removeAtIndex(sourceIndexPath.row)
        project.insert(movedObject, atIndex: destinationIndexPath.row)
    }
}

