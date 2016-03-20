//
//  Player.swift
//  1942
//
//  Created by Michael Nikolaev on 20.03.16.
//  Copyright © 2016 Michael Nikolaev. All rights reserved.
//

import Foundation

class Player: Entity {
    var imageName = "Player"
    var leftInset = 0
    var bottomInset = 0
    var topInset = 0
    
    var lives = 3
    var maxLives = 5
    
    init() {}
}