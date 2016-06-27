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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        for i in 0..<2 {
            for j in 0..<4 {
                print("\(students[i * 2 + j].studentName ?? "No Name")")
            }
        }
        showListOfStudent()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    
    }
    
    func loadData() {
        let names = ["Quang", "Phu", "Chi", "Minh", "Kim", "Loan", "Le", "Thi"]
        let avatar = "avatar.png"
        
        for i in 0..<names.count {
            let student = Student(imageName: avatar, studentName: names[i])
            students.append(student)
        }
    }
    
    func showListOfStudent() {
        
        let screen = UIScreen.mainScreen().bounds
        
        let widthAvatar: CGFloat = screen.size.width / 4
        let heightAvatar: CGFloat = 120
        
        let count = 15
        
        var row = 0
        var col = 0
        
        for index in 0..<count {
            var frame = CGRectMake(CGFloat(col) * widthAvatar, CGFloat(row) * heightAvatar, widthAvatar, heightAvatar)
            if frame.origin.x >= screen.size.width {
                row += 1
                col = 0
                frame = CGRectMake(CGFloat(col) * widthAvatar, CGFloat(row) * heightAvatar, widthAvatar, heightAvatar)
            }
            let myView = NSBundle.mainBundle().loadNibNamed("AvatarView", owner: self, options: nil).last as! AvatarView
            myView.frame = frame
            //                    AvatarView(frame: frame)
            //                if let name = students[i * col + j].studentName {
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
