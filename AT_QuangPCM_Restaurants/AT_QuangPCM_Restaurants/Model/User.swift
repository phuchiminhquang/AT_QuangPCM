//
//  User.swift
//  AT-QuangPCM
//
//  Created by Quang Phu on 7/11/16.
//  Copyright © 2016 demo. All rights reserved.
//

import Foundation
import UIKit

class User {
    var photo: String?
    var name: String = "guest"
    var email: String = "abc@gmail.com"
    var password: String = "123"
    
    init(name: String, email: String, password: String, photo: String?) {
        self.name = name
        self.email = email
        self.password = password
        if let photo = photo {
            self.photo = photo
        }
    }
    
    func isUserExisted() -> Bool{
//        var rootDictionary: NSDictionary?
        
        //1
        if let plist = Plist(name: "Users") {
            //2
            let dict = plist.getValuesInPlistFile()!
            print(dict)
            
            if let user = dict.objectForKey(self.email) {
                let password = user["password"] as! String
                return password == self.password
            } else {
                return false
            }
        } else {
            print("Unable to get Plist")
        }

        
//        if let path = NSBundle.mainBundle().pathForResource("Users", ofType: "plist") {
//            rootDictionary = NSDictionary(contentsOfFile: path)
//            
//            let user = rootDictionary?.objectForKey(self.email) as? NSDictionary
//            
//            if let user = user {
//                let name = user.objectForKey("name") as! String
//                let password = user.objectForKey("password") as! String
//                
//                print("\(email) \(name) \(password)")
//                if password == self.password {
//                    return true
//                }
//            }
//        }
        
        return false
    }
    
}