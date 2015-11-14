//
//  MemoriesTableViewController.swift
//  MyStory
//
//  Created by Jason Chen-Ju Hsieh on 11/12/15.
//  Copyright © 2015 Team 19. All rights reserved.
//

import UIKit

class MemoriesTableViewController: UITableViewController {
    
    // MARK: Properties
    
    var memories = [Memories]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Use the edit button item provided by the table view controller.
        navigationItem.rightBarButtonItem = editButtonItem()
        
        if let saveMemories = loadMemories() {
            memories += saveMemories
        }
        
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

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memories.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "MemoriesTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! MemoriesTableViewCell
        
        // Fetches the appropriate memory for the data source layout.
        let memory = memories[indexPath.row]

        cell.nameLabel.text = memory.name
        cell.imageLabel.image = memory.photo
        cell.descriptionLabel.text = memory.photoDescription
        

        return cell
    }


    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }



    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            memories.removeAtIndex(indexPath.row)
            saveMemories()
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }


    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowDetail" {
            let memoryDetailViewController = segue.destinationViewController as! AddMemoriesViewController
            
            // Get the cell that generated this segue.
            if let selectedMemoryCell = sender as? MemoriesTableViewCell {
                let indexPath = tableView.indexPathForCell(selectedMemoryCell)!
                let selectedMemory = memories[indexPath.row]
                memoryDetailViewController.memory = selectedMemory
            }
        }
    }
    
    @IBAction func prepareForUnwind(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.sourceViewController as? AddMemoriesViewController, memory = sourceViewController.memory {
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                // Update an existing memory.
                memories[selectedIndexPath.row] = memory
                tableView.reloadRowsAtIndexPaths([selectedIndexPath], withRowAnimation: .None)
            } else {
                // Add a new memory.
                let newIndexPath = NSIndexPath(forRow: memories.count, inSection: 0)
                memories.append(memory)
                tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Bottom)
            }
            saveMemories()
        }
    }
    
    // MARK: NSCoding
    
    func saveMemories() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(memories, toFile: Memories.ArchiveURL.path!)
        if !isSuccessfulSave {
            print("Failed to save memories...")
        }
    }
    
    func loadMemories() -> [Memories]? {
        return NSKeyedUnarchiver.unarchiveObjectWithFile(Memories.ArchiveURL.path!) as? [Memories]
    }

}
