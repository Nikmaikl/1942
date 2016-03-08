//
//  InterfaceController.swift
//  1942 WatchKit Extension
//
//  Created by Michael Nikolaev on 06.03.16.
//  Copyright © 2016 Michael Nikolaev. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {

    var playerImages = [UIImage]()
    
    @IBOutlet var playerImage: WKInterfaceImage!
    @IBOutlet var playerGroup: WKInterfaceGroup!
    
    @IBOutlet var enemyGroup: WKInterfaceGroup!
    @IBOutlet var bulletGroup: WKInterfaceGroup!
    
    @IBOutlet var picker: WKInterfacePicker!
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        var items = [WKPickerItem]()
        
        for _ in 0..<100 {
            let pickertem = WKPickerItem()
            items.append(pickertem)
        }
        picker.setItems(items)
        
        
        self.bulletGroup.setAlpha(0.0)
        
        NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector: "respawnEnemies", userInfo: nil, repeats: true)
//        NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "fire", userInfo: nil, repeats: true)
        
        respawnEnemies()
    }

    @IBAction func pickerChanged(value: Int) {
        self.playerGroup.setContentInset(UIEdgeInsets(top: 0, left: CGFloat(value), bottom: 0, right: 0))
        self.bulletGroup.setContentInset(UIEdgeInsets(top: 0, left: CGFloat(value), bottom: 0, right: 0))
    }
    
    func getRandomHorizontalAlignment() -> WKInterfaceObjectHorizontalAlignment {
        let num = Int(arc4random_uniform(3))
        if num == 0 {
            return .Center
        } else if num == 1 {
            return .Left
        } else {
            return .Right
        }
    }
    
    func respawnEnemies() {
        self.enemyGroup.setVerticalAlignment(.Top)
        self.enemyGroup.setContentInset(UIEdgeInsets(top: 0, left: CGFloat(arc4random_uniform(100)), bottom: 0, right: 0))
        self.enemyGroup.setAlpha(1.0)
        
        self.animateWithDuration(3, animations: {
            self.enemyGroup.setVerticalAlignment(.Bottom)
            self.enemyGroup.setAlpha(0.0)
        })
    }
    
    func fire() {
        self.bulletGroup.setVerticalAlignment(.Bottom)
        self.bulletGroup.setAlpha(1.0)
        
        self.animateWithDuration(3, animations: {
            self.bulletGroup.setVerticalAlignment(.Top)
            self.bulletGroup.setAlpha(0.0)
        })
    }
    
    override func willActivate() {
        super.willActivate()
    }

    override func didDeactivate() {
        super.didDeactivate()
    }

}
