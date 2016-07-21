//
//  Cache.swift
//  AT_QuangPCM_Restaurants
//
//  Created by Asiantech1 on 7/20/16.
//  Copyright © 2016 Quang Phu. All rights reserved.
//

import Foundation

class Cache: NSCache {
    
    class var sharedInstance: Cache {
        struct Static {
            static var onceToken: dispatch_once_t = 0
            static var instance: Cache? = nil
        }
        dispatch_once(&Static.onceToken) {
            Static.instance = Cache()
            Static.instance?.countLimit = 20 // Max 20 images in memory.
            Static.instance?.totalCostLimit = 10*1024*1024 // Max 10MB used
        }
        return Static.instance!
    }
}