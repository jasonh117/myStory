//
//  GameView.swift
//  MyStory
//
//  Created by Jason Chen-Ju Hsieh on 11/7/15.
//  Copyright © 2015 Team 19. All rights reserved.
//

import UIKit

class GameView: UIViewController {
    

    @IBOutlet weak var testbutton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func buttonpress(sender: UIButton) {
        testbutton.setTitle("aaa", forState: UIControlState.Normal)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
