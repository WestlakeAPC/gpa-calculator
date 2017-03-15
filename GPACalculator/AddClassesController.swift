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
    
    @IBOutlet var warningLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        warningLabel.isHidden = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addNewClass(_ sender: Any) {
        if classNameField.text! != nil && multiplierField.text! != nil && currentGradeField.text! != nil{
            classesAndGrades.append(Information(name: classNameField.text!,
                                            grade: Int(currentGradeField.text!)!,
                                            mult: Double(multiplierField.text!)!))
            
            UserDefaults.standard.set(classesAndGrades, forKey: "gradesStructure")
            warningLabel.isHidden = true
            
        }
        
        warningLabel.isHidden = false
        
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
