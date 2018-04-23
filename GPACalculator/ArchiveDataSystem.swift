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
        Information.keyValueStore.set(NSKeyedArchiver.archivedData(withRootObject: infoList), forKey: key)
    }
}