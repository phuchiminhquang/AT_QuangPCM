//
//  RootController.swift
//  Bai 4
//
//  Created by Quang Phu on 6/27/16.
//  Copyright © 2016 Quang Phu. All rights reserved.
//

import UIKit

class RootController: UIViewController {

    var students = [Student]()
    let count = 15
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(animated: Bool) {
        loadData()
        showListOfStudent(15)
    }
    
    override func viewDidAppear(animated: Bool) {
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    
    }
    
    // MARK: private function
    func loadData() {
        let names = ["Quang", "Phu", "Chi", "Minh", "Kim", "Loan", "Le", "Thi"]
        let avatar = "avatar.png"
        
        for i in 0..<names.count {
            let student = Student(imageName: avatar, studentName: names[i])
            students.append(student)
        }
    }
    
    func showListOfStudent(count: Int = 10) {
        
        let screen = UIScreen.mainScreen().bounds
        
        let widthAvatar: CGFloat = screen.size.width / 4
        let heightAvatar: CGFloat = 120
        
        var row = 0
        var col = 0
        
        for index in 0..<count {
            var frame = CGRectMake(CGFloat(col) * widthAvatar, CGFloat(row) * heightAvatar, widthAvatar, heightAvatar)
            if frame.origin.x >= screen.size.width {
                row += 1; col = 0
                frame = CGRectMake(CGFloat(col) * widthAvatar, CGFloat(row) * heightAvatar, widthAvatar, heightAvatar)
            }
            
            let myView = NSBundle.mainBundle().loadNibNamed("AvatarView", owner: self, options: nil).last as! AvatarView
            
            myView.frame = frame
            myView.nameLabel.text = "\(students[index % students.count].studentName ?? "No Name")"
            myView.avatarImageView.image = UIImage(named: students[index % students.count].imageName)
            myView.tag = index
            myView.delegate = self
            
            self.view.addSubview(myView)
            
            col += 1
        }
    }
   
}


extension RootController: AvatarViewDelegate {
    func didSelectAvatar(myView: AvatarView, tag: Int) {
        if let student: Student = students[tag] {
            student.tap(tag)
        }
    }
}
