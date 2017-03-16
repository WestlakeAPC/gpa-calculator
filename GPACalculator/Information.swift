//
//  classInfo.swift
//  GPACalculator
//
//  Created by Joseph Jin on 3/14/17.
//  Copyright © 2017 Animator Joe. All rights reserved.
//

import Foundation

class Information: NSCoding {
    var name: String
    var grade: Int
    var multiplier: Double
    
    // Initialize
    init(name: String, grade: Int, multiplier: Double) {
        self.name = name
        self.grade = grade
        self.multiplier = multiplier
    }

    public required convenience init?(coder aDecoder: NSCoder) {
        let name = aDecoder.decodeObject(forKey: "name") as! String
        let grade = aDecoder.decodeInteger(forKey: "grade")
        let multiplier = aDecoder.decodeDouble(forKey: "multiplier")
        self.init(name: name, grade: grade, multiplier: multiplier)
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "name")
        aCoder.encode(grade, forKey: "grade")
        aCoder.encode(multiplier, forKey: "multiplier")
    }

}
