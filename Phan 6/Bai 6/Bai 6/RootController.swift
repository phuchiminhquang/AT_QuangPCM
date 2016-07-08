//
//  RootController.swift
//  Bai 4
//
//  Created by Quang Phu on 7/6/16.
//  Copyright © 2016 Quang Phu. All rights reserved.
//

import UIKit



class RootController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    // MARK: IBOutlet & IBAction
    @IBOutlet weak var myTableView: UITableView!
    
    
    // MARK: Property
    var studentslist: [[Student]] = []
    let names = [["Nguyen Van A","Nguyen Van B","Nguyen Van C","Nguyen Van D","Nguyen Van E","Le Thi Meo",],
                 ["Le Thi Mui","Le Thi Ti","Tran Suu","Mau","Le Thi X", "Ba Van Y","Nguyen Van A","Nguyen Van B","Nguyen Van C","Nguyen Van D","Nguyen Van E","Le Thi Meo"],
                 ["Le Thi Mui","Le Thi Ti","Tran Suu","Mau","Le Thi X", "Ba Van Y","Nguyen Van A","Nguyen Van B","Nguyen Van C","Nguyen Van D","Nguyen Van E","Le Thi Meo"],
                 ["Le Thi Mui","Le Thi Ti","Tran Suu","Mau","Le Thi X", "Ba Van Y","Nguyen Van A","Nguyen Van B","Nguyen Van C","Nguyen Van D","Nguyen Van E","Le Thi Meo"],
                 ["Le Thi Mui","Le Thi Ti","Tran Suu","Mau","Le Thi X", "Ba Van Y"]]
    
    let ages = [20,21,22,23,25,24]
    let genders = ["Male", "Female"]
    let photos = ["bg_horse.jpg","bg_blur.jpg","torres.jpg"]
    
    let cellIdentifier = "CustomCell"
    let headerIdentifier = "TableSectionHeader"
    let footerIdentifier = "TableSectionFooter"
    
    let headerTitles = ["A","B","C","D","E","F"]
    let headerPhotos = ["headerPhoto","headerPhoto2"]
    
    
    // MARK: Init View
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Home"
        
        var nib = UINib(nibName: "CustomTableViewCell", bundle: nil)
        myTableView.registerNib(nib, forCellReuseIdentifier: cellIdentifier)
        
        // Register xib file for HeaderFooter
        nib = UINib(nibName: self.headerIdentifier, bundle: nil)
        myTableView.registerNib(nib, forHeaderFooterViewReuseIdentifier: self.headerIdentifier)
        
        nib = UINib(nibName: self.footerIdentifier, bundle: nil)
        myTableView.registerNib(nib, forHeaderFooterViewReuseIdentifier: self.footerIdentifier)
        
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
            var students: [Student] = []
            for j in 0..<names[i].count {
                let photo = UIImage(named: photos[j % photos.count])
                let student = Student(name: names[i][j], age: ages[j % ages.count], gender: genders[j % genders.count], photo: photo!)
                students.append(student)
            }
            self.studentslist.append(students)
        }
    }
    
    func moreDetail(student: Student, atIndex index: Int) {
        let detailController = ProfileController(nibName: "ProfileController", bundle: nil)
        detailController.loadData(true,student: student ,index: index)
        detailController.delegate = self
        self.navigationController?.pushViewController(detailController, animated: true)
    }
    
    
    // MARK: UITableViewDataSource
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return studentslist.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return studentslist[section].count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let student = studentslist[indexPath.section][indexPath.row]
        
        let cell: CustomTableViewCell? = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as? CustomTableViewCell
        cell?.photoImageView.image = student.photo
        cell?.nameLabel.text = student.name
        cell?.infoLabel.text = "\(indexPath.row) Age: \(student.age)     Gender: \(student.gender)"
        cell?.accessoryType = UITableViewCellAccessoryType.DetailButton
        print("\(indexPath.row)")
        return cell!
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }

    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let header: TableSectionHeader? = self.myTableView.dequeueReusableHeaderFooterViewWithIdentifier(self.headerIdentifier) as? TableSectionHeader
        let header = NSBundle.mainBundle().loadNibNamed(self.headerIdentifier, owner: self, options: nil)[0] as! TableSectionHeader
        header.photoHeader.image = UIImage(named: self.headerPhotos[section % 2])
        header.titleHeader.text = "Header \(self.headerTitles[section])"
        return header
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = NSBundle.mainBundle().loadNibNamed(self.footerIdentifier, owner: self, options: nil)[0] as! TableSectionFooter
        footer.titleFooter.text = "Footer \(self.headerTitles[section % self.headerTitles.count])"
        return footer

    }
    
    // MARK: UITableViewDelegate
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        moreDetail(studentslist[indexPath.section][indexPath.row], atIndex: indexPath.row)
    }
    
    func tableView(tableView: UITableView, accessoryButtonTappedForRowWithIndexPath indexPath: NSIndexPath) {
        moreDetail(studentslist[indexPath.section][indexPath.row], atIndex: indexPath.row)
    }
}

extension RootController: ProfileControllerDelegate {
    func updateStudentInfo(student: Student, atIndex index: Int) {
//        studentslist[index].name = student.name
//        studentslist[index].age = student.age
//        studentslist[index].gender = student.gender
//        studentslist[index].photo = student.photo
        
        myTableView.reloadData()
    }
}



























