//
//  MenuInterfaceController.swift
//  1942
//
//  Created by Michael Nikolaev on 13.03.16.
//  Copyright © 2016 Michael Nikolaev. All rights reserved.
//

import WatchKit
import Foundation

let userDefaults = NSUserDefaults.standardUserDefaults()

class MenuInterfaceController: WKInterfaceController {

    @IBOutlet var scoreLabel: WKInterfaceLabel!
    @IBOutlet var levelLabel: WKInterfaceLabel!
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)


        // Configure interface objects here.
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        if let bestScore = userDefaults.objectForKey("best_score") as? Int {
            scoreLabel.setText("\(bestScore)")
            
            let level = bestScore / 20 + 1
            print(level)
            levelLabel.setText("\(level)")
        }
        

        
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
