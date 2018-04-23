//
//  ArchiveDataSystem.swift
//  GPACalculator
//
//  Created by Joseph Jin on 4/22/18.
//  Copyright © 2018 Westlake APC. All rights reserved.
//

import Foundation

class ArchiveDataSystem {
    // Enable storing for userdefaults in this function
    static func archiveGradeData(infoList : [Information], key: String) {
        var currTime = Date();
        
        Information.keyValueStore.set(NSKeyedArchiver.archivedData(withRootObject: infoList), forKey: key)
        Information.keyValueStore.set(NSKeyedArchiver.archivedData(withRootObject: currTime), forKey: "timeStamp")
        
        UserDefaults.standard.set(infoList, forKey: key)
        UserDefaults.standard.set(currTime, forKey: "timeStamp")
    }
}
