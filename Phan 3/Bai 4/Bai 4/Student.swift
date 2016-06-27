//
//  Student.swift
//  Bai 4
//
//  Created by Quang Phu on 6/27/16.
//  Copyright © 2016 Quang Phu. All rights reserved.
//

import Foundation

class Student {
    var imageName = ""
    var studentName = ""
    
    init(imageName: String, studentName: String) {
        self.imageName = imageName
        self.studentName = studentName
    }
    
    func getImageName() -> String {
        return self.imageName
    }
    
    func getStudentName() -> String {
        return self.studentName
    }
    
    func tap(tag: Int) {
        print("Seleted view tag : \(tag) with name: \(self.studentName)")
    }
}