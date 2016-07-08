//
//  RootController.swift
//  Bai 3
//
//  Created by Quang Phu on 7/6/16.
//  Copyright © 2016 Quang Phu. All rights reserved.
//

import UIKit

class RootController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    // MARK: IBOutlet & IBAction
    
    
    // MARK: Property
    var studentslist: [Student] = []
    let names = ["Nguyen Van A","Nguyen Van B","Nguyen Van C","Nguyen Van D","Nguyen Van E","Le Thi Meo",
                 "Le Thi Mui","Le Thi Ti","Tran Suu","Mau","Le Thi X", "Ba Van Y","Nguyen Van A","Nguyen Van B","Nguyen Van C","Nguyen Van D","Nguyen Van E","Le Thi Meo",
                 "Le Thi Mui","Le Thi Ti","Tran Suu","Mau","Le Thi X", "Ba Van Y","Nguyen Van A","Nguyen Van B","Nguyen Van C","Nguyen Van D","Nguyen Van E","Le Thi Meo",
                 "Le Thi Mui","Le Thi Ti","Tran Suu","Mau","Le Thi X", "Ba Van Y","Nguyen Van A","Nguyen Van B","Nguyen Van C","Nguyen Van D","Nguyen Van E","Le Thi Meo",
                 "Le Thi Mui","Le Thi Ti","Tran Suu","Mau","Le Thi X", "Ba Van Y"]
    let ages = [20,21,22,23,25,24]
    let genders = ["male", "female"]
    
    // MARK: Init View
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func viewWillAppear(animated: Bool) {
        loadData()
    }
    
    override func viewDidAppear(animated: Bool) {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    // MARK: private function
    func loadData() {
        for i in 0..<names.count {
            let student = Student(name: names[i], age: ages[i % ages.count], gender: genders[i % genders.count])
            studentslist.append(student)
        }
    }
    
    
    // MARK: UITableViewDataSource
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return studentslist.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell? = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "CustomCell")
        
        cell?.textLabel!.text = studentslist[indexPath.row].nane
        cell?.detailTextLabel!.text = "Age: \(studentslist[indexPath.row].age)       Gender:  \(studentslist[indexPath.row].gender)"
        cell?.imageView?.image = UIImage(imageLiteral: "bg_blur.jpg")
        return cell!
        
    }
    
    
}
