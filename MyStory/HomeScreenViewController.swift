//
//  ViewController.swift
//  MyStory
//
//  Created by Jason Chen-Ju Hsieh on 11/7/15.
//  Copyright © 2015 Team 19. All rights reserved.
//

import UIKit

class HomeScreenViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation
    
    @IBAction func prepareForUnwind(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.sourceViewController as? AddMemoriesViewController, memory = sourceViewController.memory {
            var mem = NSKeyedUnarchiver.unarchiveObjectWithFile(Memories.ArchiveURL.path!) as! [Memories]
            mem.append(memory)
            NSKeyedArchiver.archiveRootObject(mem, toFile: Memories.ArchiveURL.path!)
        }
    }
    
}

