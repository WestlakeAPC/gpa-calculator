//
//  classInfo.swift
//  GPACalculator
//
//  Created by Joseph Jin on 3/14/17.
//  Copyright © 2017 Animator Joe. All rights reserved.
//

import Foundation

class Information: NSCoding {
    
    static var classesAndGrades = [[String: Any]]()
    
    var name: String
    var grade: Int
    var multiplier: Double
    var credits: Double
    
    // Initialize
    init(name: String, grade: Int, multiplier: Double, credits: Double) {
        self.name = name
        self.grade = grade
        self.multiplier = multiplier
        self.credits = credits
    }

    public required convenience init?(coder aDecoder: NSCoder) {
        let name = aDecoder.decodeObject(forKey: "name") as! String
        let grade = aDecoder.decodeInteger(forKey: "grade")
        let multiplier = aDecoder.decodeDouble(forKey: "multiplier")
        let credits = aDecoder.decodeDouble(forKey: "credits")
        self.init(name: name, grade: grade, multiplier: multiplier, credits: credits)
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "name")
        aCoder.encode(grade, forKey: "grade")
        aCoder.encode(multiplier, forKey: "multiplier")
        aCoder.encode(credits, forKey: "credits")
    }
}
