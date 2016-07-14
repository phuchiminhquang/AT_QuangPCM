//
//  Restaurant.swift
//  AT_QuangPCM_Restaurants
//
//  Created by Quang Phu on 7/14/16.
//  Copyright © 2016 Quang Phu. All rights reserved.
//

import Foundation

class Food {
    var name = ""
    var description = ""
    var photo: [String]?
    
    init(name: String?, des: String?, photo: [String]?) {
        self.name = name ?? ""
        self.description = des ?? ""
        self.photo = photo ?? []
    }
}

class Restaurant {
    
    // 
    var name = ""
    var photo = "no_picture"
    var address = ""
    
    var longDes = ""
    var shortDes = ""
    
    var latitue: Double = 0.0
    var longtitue: Double = 0.0
    
    var food: [Food]?
    
    var rating = 0
    var isFavoratie = false
    
 
    
}