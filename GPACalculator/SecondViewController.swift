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

class SecondViewController: UIViewController {
    
    @IBOutlet weak var westlakeGPALabel: UILabel!
    @IBOutlet weak var standardGPALabel: UILabel!
    @IBOutlet weak var letterGradeLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        Information.initialize()
        
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
            letterGradeLabel.text = ""
            return
        }
        
        let westlakeGPA = (totalWestlakeGrades / Double(Information.classesAndGrades.count) * 100.0).rounded() / 100.0
        westlakeGPALabel.text = "Westlake GPA: \(westlakeGPA)"
        
        let standardGPA = (totalStandardGrades / totalStandardCredit).rounded()
        
        var fourPointScale: Double = -1
        var letter: String = ""
        switch (standardGPA) {
            case 0..<65:
                fourPointScale = 0
                letter = "E/F"
            case 65...66:
                fourPointScale = 1
                letter = "D"
            case 67...69:
                fourPointScale = 1.3
                letter = "D+"
            case 70...72:
                fourPointScale = 1.7
                letter = "C-"
            case 73...76:
                fourPointScale = 2.0
                letter = "C"
            case 77...79:
                fourPointScale = 2.3
                letter = "C+"
            case 80...82:
                fourPointScale = 2.7
                letter = "B-"
            case 83...86:
                fourPointScale = 3.0
                letter = "B"
            case 87...89:
                fourPointScale = 3.3
                letter = "B+"
            case 90...92:
                fourPointScale = 3.7
                letter = "A-"
            case 93...96:
                fourPointScale = 4.0
                letter = "A"
            case 97...100:
                fourPointScale = 4.0
                letter = "A+"
            default:
                break
        }
        
        guard fourPointScale != -1, !letter.isEmpty else {
            print("Invalid grades")
            
            westlakeGPALabel.text = ""
            standardGPALabel.text = ""
            letterGradeLabel.text = ""
            return
        }
        
        standardGPALabel.text = "4.0 Scale GPA: \(fourPointScale)"
        letterGradeLabel.text = "Letter Grade: \(letter)"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

