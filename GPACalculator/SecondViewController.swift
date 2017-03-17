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

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if UserDefaults.standard.object(forKey: "savedList") != nil {
            Information.classesAndGrades = UserDefaults.standard.object(forKey: "savedList") as! [[String: Any]]
        }
        
        var totalCredit = 0.0;
        
        for classAndGrade in Information.classesAndGrades {
            totalCredit += (classAndGrade["grade"] as! Double) * (classAndGrade["multiplier"] as! Double)
        }
        
        let westlakeGPA = totalCredit / Double(Information.classesAndGrades.count)
        westlakeGPALabel.text = "Westlake GPA: \(westlakeGPA)"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

