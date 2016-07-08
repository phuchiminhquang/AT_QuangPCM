//
//  Student.swift
//  Bai 3
//
//  Created by Quang Phu on 7/6/16.
//  Copyright © 2016 Quang Phu. All rights reserved.
//

import Foundation
import UIKit

class Student {

    var name = "No Name"
    var age = 0
    var gender = "No gender"
    var photo = UIImage(named: "torres.jpg")
    
//    var name1: String {
//        get {
//            return name1
//        }
//        set (newName) {
//            self.name1 = name1
//        }
//    }
    
    init(name: String, age: Int, gender: String, photo: UIImage) {
        self.name = name
        self.age = age
        self.gender = gender
        self.photo = photo
    }
    
    
}