//
//  GradeChangerController.swift
//  GPACalculator
//
//  Created by Joseph Jin on 3/17/17.
//  Copyright © 2017 Animator Joe. All rights reserved.
//

import UIKit

class GradeChangerController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var selected = 0;
    
    @IBOutlet var picker: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        picker.delegate = self
        picker.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return (Information.classesAndGrades[row]["name"] as! String?)! as String
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int{
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        return Information.classesAndGrades.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selected = row
    }

}
