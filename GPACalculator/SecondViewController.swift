//
//  View GPA
//
//  SecondViewController.swift
//  GPACalculator
//
//  Created by Joseph Jin on 1/8/17.
//  Copyright © 2017 Animator Joe. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    
    @IBOutlet weak var westlakeGPALabel: UILabel!
    @IBOutlet weak var standardGPALabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if UserDefaults.standard.object(forKey: "savedList") != nil {
            Information.classesAndGrades = UserDefaults.standard.object(forKey: "savedList") as! [[String: Any]]
        }
        
        var totalWestlakeGrades = 0.0;
        var totalStandardCredit = 0.0;
        var totalStandardGrades = 0.0;
        
        for classAndGrade in Information.classesAndGrades {
            totalWestlakeGrades += (classAndGrade["grade"] as! Double) * (classAndGrade["multiplier"] as! Double)
            totalStandardGrades += (classAndGrade["grade"] as! Double) * (classAndGrade["credits"] as! Double)
            totalStandardCredit += classAndGrade["credits"] as! Double
        }
        
        guard totalStandardCredit != 0, Information.classesAndGrades.count != 0 else {
            print("Division by zero in GPA calculation.")
            
            westlakeGPALabel.text = ""
            standardGPALabel.text = ""
            return
        }
        
        let westlakeGPA = totalWestlakeGrades / Double(Information.classesAndGrades.count)
        westlakeGPALabel.text = "Westlake GPA: \(westlakeGPA)"
        
        let standardGPA = totalStandardGrades / totalStandardCredit
        standardGPALabel.text = "Standard GPA: \(standardGPA)"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

