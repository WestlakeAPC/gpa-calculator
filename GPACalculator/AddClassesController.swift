//
//  Add Classes
//
//  AddClasses.swift
//  GPACalculator
//
//  Created by Joseph Jin on 3/14/17.
//  Copyright © 2017 Animator Joe. All rights reserved.
//

import UIKit

class AddClassesController: UIViewController {

    @IBOutlet var classNameField: UITextField!
    @IBOutlet var multiplierField: UITextField!
    @IBOutlet var currentGradeField: UITextField!
    
    @IBOutlet var multiplierBar: UISegmentedControl!
    @IBOutlet var warningLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        warningLabel.isHidden = true
        
        if UserDefaults.standard.object(forKey: "savedList") != nil {
            classesAndGrades = UserDefaults.standard.object(forKey: "savedList") as! [Information]
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func addNewClass(_ sender: Any) {
        
        //Class name
        var className = classNameField.text!
        print(className)
        
        //Multiplier
        var multiplier:Double = -1
        
        switch multiplierBar.selectedSegmentIndex {
            case 0:
                multiplier = 1
                break
            case 1:
                multiplier = 1.1
                break
            case 2:
                multiplier = 1.2
                break
            case 3:
                if multiplierField.text != ""{
                    multiplier = Double(multiplierField.text!)!
                }
            default:
                if multiplierField.text != ""{
                    multiplier = Double(multiplierField.text!)!
            }
        }
        print(multiplier)
        
        //Current grade
        var currentGrade = -1
        
        if currentGradeField.text! != "" {
            currentGrade = Int(currentGradeField.text!)!
        }
        print(currentGrade)
        
        //Add class
        if className != "" && multiplier != -1 && currentGrade != -1{
            
            print(className + " " + String(currentGrade) + " " + String(multiplier))
            
            classesAndGrades.append(Information(name: className, grade: currentGrade, mult: multiplier))
            
            UserDefaults.standard.set(classesAndGrades, forKey: "savedList")
            
            warningLabel.isHidden = true
            
        } else {
        
            warningLabel.isHidden = false
            
        }
        
    }
    
    
    
    
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
