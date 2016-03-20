//
//  Entity.swift
//  1942
//
//  Created by Michael Nikolaev on 20.03.16.
//  Copyright © 2016 Michael Nikolaev. All rights reserved.
//

import Foundation

protocol Entity {
    var imageName: String { get set }
    var leftInset: Int { get set }
    var bottomInset: Int { get set }
    var topInset: Int { get set }
    
}