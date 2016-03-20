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
    @IBOutlet var enemyImage: WKInterfaceImage!
    
    @IBOutlet var bulletGroup: WKInterfaceGroup!
    @IBOutlet var enemyBulletGroup: WKInterfaceGroup!
    
    @IBOutlet var picker: WKInterfacePicker!
    
    @IBOutlet var scoreLabel: WKInterfaceLabel!
    @IBOutlet var livesLabel: WKInterfaceLabel!
    
    var score = 0

    var playerInsetLeft = 0
    
    var respawnEnemiesTimer: NSTimer!
    var fireTimer: NSTimer!
    
    let player = Player()
    let enemy = Enemy()
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        player.lives = player.maxLives
        resetStats()
        
        var items = [WKPickerItem]()
        
        for _ in 0..<100 {
            let pickertem = WKPickerItem()
            items.append(pickertem)
        }
        picker.setItems(items)
        
        self.bulletGroup.setAlpha(0.0)
        
        respawnEnemiesTimer = NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector: "respawnEnemies", userInfo: nil, repeats: true)
        fireTimer = NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector: "fire", userInfo: nil, repeats: true)
        respawnEnemies()
    }
    
    var movingTimes = 0
    
    @IBAction func pickerChanged(value: Int) {
        self.animateWithDuration(0.7, animations: {
            self.playerInsetLeft = value
            self.playerGroup.setContentInset(UIEdgeInsets(top: 0, left: CGFloat(self.playerInsetLeft), bottom: 0, right: 0))
            self.playerGroup.sizeToFitWidth()
            self.playerGroup.sizeToFitWidth()
            
            self.bulletGroup.setContentInset(UIEdgeInsets(top: 0, left: CGFloat(value+14), bottom: 0, right: 0))
            self.bulletGroup.sizeToFitWidth()
            self.bulletGroup.sizeToFitWidth()
        })
        
        movingTimes += 1
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
        enemy.leftInset = Int(arc4random_uniform(100))
        enemyImage.stopAnimating()
        enemyImage.setImageNamed("enemy")
        
        self.enemyGroup.setContentInset(UIEdgeInsets(top: 0, left: CGFloat(enemy.leftInset), bottom: 0, right: 0))
        self.enemyGroup.sizeToFitWidth()
        self.enemyGroup.sizeToFitWidth()
        self.enemyGroup.setAlpha(1.0)
        
        enemyFire()
        
        self.animateWithDuration(3, animations: {
            self.enemyGroup.setVerticalAlignment(.Bottom)
        })
    }
    
    func fire() {
        self.bulletGroup.setVerticalAlignment(.Bottom)
        self.bulletGroup.setAlpha(1.0)
        if (playerInsetLeft >= enemy.leftInset-15) && (playerInsetLeft <= enemy.leftInset+15){
            WKInterfaceDevice.currentDevice().playHaptic(.Click)
            score += 1
            scoreLabel.setText("\(score)")
//            enemyImage.setImageNamed("fire")
//            enemyImage.startAnimatingWithImagesInRange(NSMakeRange(0, 5), duration: 0.5, repeatCount: 1)
        }
        
        self.animateWithDuration(0.7, animations: {
            self.bulletGroup.setVerticalAlignment(.Top)
            self.bulletGroup.setAlpha(0.0)
        })
    }

    func enemyFire() {
        self.enemyBulletGroup.setVerticalAlignment(.Top)
        self.enemyBulletGroup.setContentInset(UIEdgeInsets(top: 0, left: CGFloat(enemy.leftInset+14), bottom: 0, right: 0))
        self.enemyBulletGroup.setAlpha(1.0)
        if (playerInsetLeft >= enemy.leftInset-10) && (playerInsetLeft <= enemy.leftInset+10){
            player.lives -= 1
            livesLabel.setText("\(player.lives)")
            if player.lives == 0 {
                saveBestScore()
                pushControllerWithName("Game_over", context: nil)
            }
        }
        
        self.animateWithDuration(0.7, animations: {
            self.enemyBulletGroup.setVerticalAlignment(.Bottom)
            self.enemyBulletGroup.setAlpha(0.0)
        })
    }
    
    override func willActivate() {
        super.willActivate()
        resetStats()
    }

    override func didDeactivate() {
        super.didDeactivate()
        saveBestScore()
        respawnEnemiesTimer.invalidate()
        fireTimer.invalidate()
    }
    
    func resetStats() {
        score = 0
        player.lives = player.maxLives
        livesLabel.setText("\(player.lives)")
    }
    
    func saveBestScore() {
        if let bestScore = userDefaults.objectForKey("best_score") as? Int {
            if score > bestScore {
                userDefaults.setInteger(score, forKey: "best_score")
            }
        }
        score = 0
    }

}
