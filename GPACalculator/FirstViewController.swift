//
//  Edit Classes
//
//  FirstViewController.swift
//  GPACalculator
//
//  Created by Joseph Jin on 1/8/17.
//  Copyright © 2017 Animator Joe. All rights reserved.
//

import UIKit

var classesAndGrades = [[Any]]()

class FirstViewController: UIViewController, UITableViewDelegate {

    @IBOutlet var classTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if UserDefaults.standard.object(forKey: "savedList") != nil {
            classesAndGrades = UserDefaults.standard.object(forKey: "savedList") as! [[Any]]
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //Updates table
        classTable.reloadData()
        //print(classesAndGrades)
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        print("You have " + String(classesAndGrades.count) + " classes")
        return classesAndGrades.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAtIndexPath indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "Cell")
        
        cell.textLabel?.text = String(describing: classesAndGrades[indexPath.row])
        
        return cell
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

