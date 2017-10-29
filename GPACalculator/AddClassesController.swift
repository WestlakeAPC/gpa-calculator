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

class AddClassesController: UIViewController {

    @IBOutlet var classNameField: UITextField!
    @IBOutlet var multiplierField: UITextField!
    @IBOutlet var currentGradeField: UITextField!
    @IBOutlet var creditsField: UITextField!
    
    @IBOutlet var multiplierBar: UISegmentedControl!
    @IBOutlet var creditsBar: UISegmentedControl!
    
    @IBOutlet var addClassButton: UIButton!
    @IBOutlet var cancelButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cancelButton.isEnabled = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Exit View
    @IBAction func exit(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addNewClass(_ sender: Any) {
        // Class name
        guard let className = classNameField.text, !className.isEmpty else {
            showWarning()
            print("No class name specified.")
            return
        }
        
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
                    showWarning()
                    print("No multiplier specified.")
                    return
                }
                
                // Can't use guard without let.
                guard let _multiplier = Double(multiplierText) else {
                    showWarning()
                    print("Malformed multiplier.")
                    return
                }
                multiplier = _multiplier
        }
        
        // Current grade
        guard let currentGradeText = currentGradeField.text, !currentGradeText.isEmpty else {
            showWarning()
            print("No current grade specified.")
            return
        }
        guard let currentGrade = Int(currentGradeText) else {
            showWarning()
            print("Malformed current grade.")
            return
        }
        
        // Credits
        var credits: Double = -1
        
        switch creditsBar.selectedSegmentIndex {
            case 0:
                credits = 0.5
            case 1:
                credits = 1.0
            default:
                guard let creditsText = creditsField.text, !creditsText.isEmpty else {
                    showWarning()
                    print("No credits specified.")
                    return
                }
                
                // Can't use guard without let.
                guard let _credits = Double(creditsText) else {
                    showWarning()
                    print("Malformed credits.")
                    return
                }
                credits = _credits
        }
        
        // Add the class
        Information.classesAndGrades.append(Information(className, grade: currentGrade, multiplier: multiplier, credits: credits))
        Information.keyValueStore.set(NSKeyedArchiver.archivedData(withRootObject: Information.classesAndGrades), forKey: "savedList")
        
        classNameField.text = ""
        multiplierField.text = ""
        multiplierBar.selectedSegmentIndex = 0
        currentGradeField.text = ""
        creditsField.text = ""
        creditsBar.selectedSegmentIndex = 0
        
        cancelButton.isEnabled = false
        
        // Let button animation finish.
        DispatchQueue.main.async {
            self.view.endEditing(true)
            
            usleep(10000)
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func showWarning() {
        self.view.makeToast("You have missing information.", duration: 3.0, position: .bottom)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
