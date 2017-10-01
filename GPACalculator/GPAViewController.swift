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
        
        let totalWestlakeGrades = Information.classesAndGrades.map({ Double($0.grade) * $0.multiplier }).reduce(0, { (sum, grade) in sum + credits })
        let totalStandardCredit = Information.classesAndGrades.map({ Double($0.grade) * $0.credits }).reduce(0, { (sum, grade) in sum + credits })
        let totalStandardGrades = Information.classesAndGrades.map({ $0.credits }).reduce(0, { (sum, credits) in sum + credits })
        
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
                setColor(.black)
                fourPointScale = 0
                letter = "E/F"
            case 65...66:
                setColor(.red)
                fourPointScale = 1
                letter = "D"
            case 67...69:
                setColor(.red)
                fourPointScale = 1.3
                letter = "D+"
            case 70...72:
                setColor(.orange)
                fourPointScale = 1.7
                letter = "C-"
            case 73...76:
                setColor(.orange)
                fourPointScale = 2.0
                letter = "C"
            case 77...79:
                setColor(.orange)
                fourPointScale = 2.3
                letter = "C+"
            case 80...82:
                setColor(.yellow)
                fourPointScale = 2.7
                letter = "B-"
            case 83...86:
                setColor(.yellow)
                fourPointScale = 3.0
                letter = "B"
            case 87...89:
                setColor(.yellow)
                fourPointScale = 3.3
                letter = "B+"
            case 90...92:
                setColor(.green)
                fourPointScale = 3.7
                letter = "A-"
            case 93...96:
                setColor(.green)
                fourPointScale = 4.0
                letter = "A"
            case 97...100:
                setColor(.green)
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
    
    func setColor(_ color: UIColor) {
        standardGPALabel.textColor = color
        letterGradeLabel.textColor = color
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

