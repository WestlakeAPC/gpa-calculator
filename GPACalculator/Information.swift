//
//  classInfo.swift
//  GPACalculator
//
//  Created by Joseph Jin on 3/14/17.
//  Copyright © 2017 Animator Joe. All rights reserved.
//

import Foundation

struct Information {
    
    var name: String
    var grade: Int
    var multiplier: Double
    
    // Initialize
    init(name: String, grade: Int, multiplier: Double) {
        self.name = name
        self.grade = grade
        self.multiplier = multiplier
    }
}
