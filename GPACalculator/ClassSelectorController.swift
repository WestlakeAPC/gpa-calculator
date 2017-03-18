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

import UIKit

class ClassSelectorController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var selected = 0
    
    @IBOutlet var classNameField: UITextField!
    @IBOutlet var multiplierField: UITextField!
    @IBOutlet var currentGradeField: UITextField!
    @IBOutlet var creditsField: UITextField!
    
    @IBOutlet var multiplierBar: UISegmentedControl!
    @IBOutlet var creditsBar: UISegmentedControl!
    
    @IBOutlet var warningLabel: UILabel!
    @IBOutlet var updatedLabel: UILabel!
    @IBOutlet var addClassButton: UIButton!
    
    @IBOutlet var doneButton: UIBarButtonItem!
    @IBOutlet var cancelButton: UIBarButtonItem!
    
    @IBOutlet var picker: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        picker.delegate = self
        picker.dataSource = self
        
        warningLabel.isHidden = true
        updatedLabel.isHidden = true
        doneButton.isEnabled = false
        cancelButton.isEnabled = true
        
        pickerView(picker, didSelectRow: 0, inComponent: 0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return Information.classesAndGrades[row]["name"] as? String
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        return Information.classesAndGrades.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selected = row
        
        classNameField.text = Information.classesAndGrades[selected]["name"] as? String
        currentGradeField.text = "\(Information.classesAndGrades[selected]["grade"] as! Int)"
        
        switch Information.classesAndGrades[selected]["multiplier"] as! Double {
            case 1.0:
                multiplierBar.selectedSegmentIndex = 0
            case 1.1:
                multiplierBar.selectedSegmentIndex = 1
            case 1.2:
                multiplierBar.selectedSegmentIndex = 2
            default:
                multiplierBar.selectedSegmentIndex = 3
                multiplierField.text = "\(Information.classesAndGrades[selected]["multiplier"] as! Double)"
        }
        
        switch Information.classesAndGrades[selected]["credits"] as! Double {
            case 0.5:
                creditsBar.selectedSegmentIndex = 0
            case 1.0:
                creditsBar.selectedSegmentIndex = 1
            default:
                creditsBar.selectedSegmentIndex = 2
                creditsField.text = "\(Information.classesAndGrades[selected]["credits"] as! Double)"
        }
    }
    
    @IBAction func updateClass(_ sender: Any) {
        // Class name
        guard let className = classNameField.text else {
            warningLabel.isHidden = false
            print("No class name specified.")
            return
        }
        
        print(className)
        
        // Multiplier
        var multiplier: Double = -1
        
        switch multiplierBar.selectedSegmentIndex {
            case 0:
                multiplier = 1
            case 1:
                multiplier = 1.1
            case 2:
                multiplier = 1.2
            default:
                guard let multiplierText = multiplierField.text, !multiplierText.isEmpty else {
                    warningLabel.isHidden = false
                    print("No multiplier specified.")
                    return
                }
                
                // Can't use guard without let.
                guard let _multiplier = Double(multiplierText) else {
                    warningLabel.isHidden = false
                    print("Malformed multiplier.")
                    return
                }
                multiplier = _multiplier
        }
        
        print(multiplier)
        
        // Current grade
        var currentGrade = -1
        
        guard let currentGradeText = currentGradeField.text, !currentGradeText.isEmpty else {
            warningLabel.isHidden = false
            print("No current grade specified.")
            return
        }
        guard let _currentGrade = Int(currentGradeText) else {
            warningLabel.isHidden = false
            print("Malformed current grade.")
            return
        }
        currentGrade = _currentGrade
        
        print(currentGrade)
        
        // Credits
        var credits: Double = -1
        
        switch creditsBar.selectedSegmentIndex {
            case 0:
                credits = 0.5
            case 1:
                credits = 1.0
            default:
                guard let creditsText = creditsField.text, !creditsText.isEmpty else {
                    warningLabel.isHidden = false
                    print("No credits specified.")
                    return
                }
                
                // Can't use guard without let.
                guard let _credits = Double(creditsText) else {
                    warningLabel.isHidden = false
                    print("Malformed credits.")
                    return
                }
                credits = _credits
        }
        
        print(credits)
        
        // Add the class
        guard className != "", multiplier != -1, currentGrade != -1 else {
            warningLabel.isHidden = false
            return
        }
        
        Information.classesAndGrades[selected] = ["name": className, "multiplier": multiplier, "grade": currentGrade, "credits": credits]
        
        Information.keyValueStore.set(Information.classesAndGrades, forKey: "savedList")
        
        classNameField.text = ""
        multiplierField.text = ""
        multiplierBar.selectedSegmentIndex = 0
        currentGradeField.text = ""
        creditsField.text = ""
        creditsBar.selectedSegmentIndex = 0
        
        warningLabel.isHidden = true
        updatedLabel.isHidden = false
        addClassButton.isHidden = true
        doneButton.isEnabled = true
        cancelButton.isEnabled = false
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}