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

class Information: NSObject, NSCoding {
    
    override public var description: String { return "\(name): \(grade) *\(multiplier) credit: \(credits)\n" }
    
    static var classesAndGrades = [Information]()
    static let keyValueStore = NSUbiquitousKeyValueStore()
    static var selectedRow: Int = 0
    
    var name: String
    var grade: Int
    var multiplier: Double
    var credits: Double
    
    // Initialize
    public init(_ name: String, grade: Int, multiplier: Double, credits: Double) {
        self.name = name
        self.grade = grade
        self.multiplier = multiplier
        self.credits = credits
    }

    public required convenience init?(coder aDecoder: NSCoder) {
        let name = aDecoder.decodeObject(forKey: "name") as? String ?? "Classy McClassFace"
        let grade = aDecoder.decodeInteger(forKey: "grade")
        let multiplier = aDecoder.decodeDouble(forKey: "multiplier")
        let credits = aDecoder.decodeDouble(forKey: "credits")
        self.init(name, grade: grade, multiplier: multiplier, credits: credits)
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "name")
        aCoder.encode(grade, forKey: "grade")
        aCoder.encode(multiplier, forKey: "multiplier")
        aCoder.encode(credits, forKey: "credits")
    }
    
    public static func initializeArray() {
        // Can't use guard without let.
        
        print("iClouds Data: \(UserDefaults.standard.object(forKey: "savedList") as? [Information]) \n \(NSKeyedUnarchiver.unarchiveObject(with: Information.keyValueStore.data(forKey: "timeStamp")!) as? Date)")
        
        // Add time stamp if there is data on iclouds
        if Information.keyValueStore.data(forKey: "savedList") != nil && Information.keyValueStore.data(forKey: "timeStamp") == nil {
            ArchiveDataSystem.archiveGradeData(infoList: (UserDefaults.standard.object(forKey: "savedList") as? [Information])!, key: "savedList")
            print("Using array from iclouds and creating time stamp")
            return
        }
        
        // If there is no data stored
        if UserDefaults.standard.object(forKey: "savedList") == nil && Information.keyValueStore.data(forKey: "savedList") == nil{
            Information.classesAndGrades = [Information]()
            print("Using new array")
            return
            
            // If there is data in userdefaults and iclouds, compare time stamps
        } else if UserDefaults.standard.object(forKey: "timeStamp") != nil && Information.keyValueStore.data(forKey: "timeStamp") != nil {
            
            let cloudDate = NSKeyedUnarchiver.unarchiveObject(with: Information.keyValueStore.data(forKey: "timeStamp")!) as? Date
            let udDate = UserDefaults.standard.object(forKey: "timeStamp") as? Date
            
            if(udDate?.compare(cloudDate!) == .orderedDescending) {
                print("Using data from userdefaults")
                Information.classesAndGrades = (NSKeyedUnarchiver.unarchiveObject(with: (UserDefaults.standard.object(forKey: "savedList") as! Data)) as? [Information])!
                return
            }
            
        }
        
        print("Using data from iclouds")
        // Use data from iclouds if no conditions are met
        guard let data = Information.keyValueStore.data(forKey: "savedList"),
            let classesAndGrades = NSKeyedUnarchiver.unarchiveObject(with: data) as? [Information] else {
                return
        }
        Information.classesAndGrades = classesAndGrades
    }
}

