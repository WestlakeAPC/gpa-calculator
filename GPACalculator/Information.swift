/**
 * Copyright (c) 2017 Westlake APC
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

import Foundation

class Information: NSCoding {
    
    static var classesAndGrades = [[String: Any]]()
    static var keyValueStore = NSUbiquitousKeyValueStore()
    
    var name: String
    var grade: Int
    var multiplier: Double
    var credits: Double
    
    // Initialize
    public init(name: String, grade: Int, multiplier: Double, credits: Double) {
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
    
    public static func initialize() {
        // Can't use guard without let.
        guard let classesAndGrades = Information.keyValueStore.array(forKey: "savedList") as? [[String: Any]] else {
            return
        }
        Information.classesAndGrades = classesAndGrades
    }
}
