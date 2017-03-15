//
//  classInfo.swift
//  GPACalculator
//
//  Created by Joseph Jin on 3/14/17.
//  Copyright © 2017 Animator Joe. All rights reserved.
//

import Foundation

class classInfo {
    
    var name: String
    var grade: Int
    var mult: Double
    var hps: Double
    
    //Initialize
    init(name:String, grade: Int, mult:Double) {
        self.name = name
        self.grade = grade
        self.mult = mult
        self.hps = Double(grade) * mult
    }
    
    //Return Grade
    func gradeInHundred() -> Double {
        return hps
    }
    
}
