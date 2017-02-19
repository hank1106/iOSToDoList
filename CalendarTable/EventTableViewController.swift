//
//  MonthsTableViewController.swift
//  CalendarTable
//
//  Created by Zihan Zhang on 3/7/16.
//  Copyright © 2016 Zihan Zhang. All rights reserved.
//

import UIKit
import CoreData
class MonthsTableViewController: UITableViewController {
    var events = [AnyObject]()
    
    @IBAction func addbutton(_ sender: UIBarButtonItem) {
        
        let alert = UIAlertController(title: "Add Event", message: "", preferredStyle: .alert)
        
        alert.addTextField(configurationHandler: { (textField) -> Void in
            textField.text = ""
        })
        
        let MyCancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default) {
            // Handle Cancel Logic here - when user press cancel button, like
            action in self.dismiss(animated: true, completion: nil)
        }
        alert.addAction(MyCancelAction)
        
        
        //3. Grab the value from the text field, and print it when the user clicks OK.
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
            let textField = alert.textFields![0] as UITextField
            let event = Event(withTitle: textField.text!)
            let encodedEvent = NSKeyedArchiver.archivedData(withRootObject: event)
            self.events.append(encodedEvent as AnyObject)
            UserDefaults.standard.set(self.events, forKey: "todo")
            UserDefaults.standard.synchronize()
            self.tableView.reloadData()
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        let eventsArray = UserDefaults.standard.array(forKey: "todo")
        if let eventsArray = eventsArray{
            events = eventsArray as [AnyObject]
        }
        return events.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "monthcell", for: indexPath)
        if let eventObj = events[indexPath.row] as? Data {
            let event = NSKeyedUnarchiver.unarchiveObject(with: eventObj) as! Event
            cell.textLabel?.text = event.title
        }
        return cell
    }
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            events.remove(at: indexPath.row)
            
            UserDefaults.standard.set(events, forKey: "todo")
            UserDefaults.standard.synchronize()
            let section = IndexSet(integer:0)
            tableView.reloadSections(section,with: .fade)
        }
    }

}
