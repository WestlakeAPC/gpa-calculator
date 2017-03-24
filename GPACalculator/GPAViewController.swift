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

class GPAViewController: UIViewController {
    
    @IBOutlet var westlakeGPALabel: UILabel!
    @IBOutlet var standardGPALabel: UILabel!
    @IBOutlet var letterGradeLabel: UILabel!

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Information.initializeArray()
        
        var totalWestlakeGrades = 0.0;
        var totalStandardCredit = 0.0;
        var totalStandardGrades = 0.0;
        
        for classAndGrade in Information.classesAndGrades {
            totalWestlakeGrades += Double(classAndGrade.grade) * classAndGrade.multiplier
            totalStandardGrades += Double(classAndGrade.grade) * classAndGrade.credits
            totalStandardCredit += classAndGrade.credits
        }
        
        guard totalStandardCredit != 0, Information.classesAndGrades.count != 0 else {
            print("Division by zero in GPA calculation.")
            
            westlakeGPALabel.text = ""
            standardGPALabel.text = ""
            letterGradeLabel.text = ""
            return
        }
        
        let westlakeGPA = (totalWestlakeGrades / Double(Information.classesAndGrades.count) * 100.0).rounded() / 100.0
        westlakeGPALabel.text = "\(westlakeGPA)"
        
        let standardGPA = (totalStandardGrades / totalStandardCredit).rounded()
        
        var fourPointScale: Double = -1
        var letter: String = ""
        switch (standardGPA) {
            case 0..<65:
                standardGPALabel.textColor = .black
                letterGradeLabel.textColor = .black
                fourPointScale = 0
                letter = "E/F"
            case 65...66:
                standardGPALabel.textColor = .red
                letterGradeLabel.textColor = .red
                fourPointScale = 1
                letter = "D"
            case 67...69:
                standardGPALabel.textColor = .red
                letterGradeLabel.textColor = .red
                fourPointScale = 1.3
                letter = "D+"
            case 70...72:
                standardGPALabel.textColor = .orange
                letterGradeLabel.textColor = .orange
                fourPointScale = 1.7
                letter = "C-"
            case 73...76:
                standardGPALabel.textColor = .orange
                letterGradeLabel.textColor = .orange
                fourPointScale = 2.0
                letter = "C"
            case 77...79:
                standardGPALabel.textColor = .orange
                letterGradeLabel.textColor = .orange
                fourPointScale = 2.3
                letter = "C+"
            case 80...82:
                standardGPALabel.textColor = .yellow
                letterGradeLabel.textColor = .yellow
                fourPointScale = 2.7
                letter = "B-"
            case 83...86:
                standardGPALabel.textColor = .yellow
                letterGradeLabel.textColor = .yellow
                fourPointScale = 3.0
                letter = "B"
            case 87...89:
                standardGPALabel.textColor = .yellow
                letterGradeLabel.textColor = .yellow
                fourPointScale = 3.3
                letter = "B+"
            case 90...92:
                standardGPALabel.textColor = .green
                letterGradeLabel.textColor = .green
                fourPointScale = 3.7
                letter = "A-"
            case 93...96:
                standardGPALabel.textColor = .green
                letterGradeLabel.textColor = .green
                fourPointScale = 4.0
                letter = "A"
            case 97...100:
                standardGPALabel.textColor = .green
                letterGradeLabel.textColor = .green
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
        
        standardGPALabel.text = "\(fourPointScale)"
        letterGradeLabel.text = "\(letter)"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

