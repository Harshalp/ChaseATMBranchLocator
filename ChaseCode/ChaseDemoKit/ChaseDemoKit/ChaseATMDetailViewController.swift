//
//  ChaseATMDetailViewController.swift
//  ChaseATMLocator
//
//  Created by harshal_s on 9/26/16.
//  Copyright © 2016 Harshal Pandhe. All rights reserved.
//

import UIKit

//This will display details of specific ATM or Branch
class ChaseATMDetailViewController: UITableViewController {

    var atmBranch: AtmBranch! = nil
    var displayArray = [Dictionary<String,String>]()
    
    /**
     Creating array with data to display on tableview     
     **/
    func createDisplayList() {
     
        displayArray.append([
            "label" : "Name",
            "value" : atmBranch.name
            ]);
        displayArray.append([
            "label" : "Type",
            "value" : atmBranch.locType
            ]);
        displayArray.append([
            "label" : "Address",
            "value" : atmBranch.address
            ]);
        displayArray.append([
            "label" : "City",
            "value" : atmBranch.city
            ]);
        displayArray.append([
            "label" : "State",
            "value" : atmBranch.state
            ]);
        displayArray.append([
            "label" : "Zip",
            "value" : atmBranch.zip
            ]);
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        createDisplayList()
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
        return displayArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:UITableViewCell = UITableViewCell(style:.value1, reuseIdentifier:"reuseIdentifier")
        
        // Configure the cell...
        var dict = displayArray[indexPath.row] 
        
        cell.textLabel?.text = dict["label"]
        cell.detailTextLabel?.text = dict["value"]

        return cell
    }
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
}
