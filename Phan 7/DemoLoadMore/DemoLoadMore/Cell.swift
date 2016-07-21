//
//  Cell.swift
//  DemoLoadMore
//
//  Created by Asiantech1 on 7/21/16.
//  Copyright © 2016 Asiantech1. All rights reserved.
//

import Foundation
import UIKit

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

class Cell {
    var name = ""
    var description = ""
    var photoURL = ""

    init(name: String, description: String, photoURL: String) {
        self.name = name
        self.description = description
        self.photoURL = photoURL
    }
    
    
    init() {
        
    }
    
    static func convertToObject(data: NSDictionary) -> Cell {
        let item = Cell()
        let id = data.objectForKey("id") as? Int ?? 0
        item.name = String(id)
        item.description = data.objectForKey("title") as? String ?? "no description"
        if let small_thumb = data.objectForKey("small_thumb") as? NSDictionary {
            item.photoURL = small_thumb.objectForKey("url") as? String ?? ""
        }
        print("\(item.name) \(item.description) \(item.photoURL)")
        return item
    }
}


extension UIImageView {
    
    func dowloadImageFrom(url: String, contentMode: UIViewContentMode) {
        

        if let image = Cache.sharedInstance.objectForKey(url) as? UIImage  {
            dispatch_async(dispatch_get_main_queue()) {
                self.contentMode = contentMode
                self.image = image
            }
        } else {
//            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
                // do your task
                UIApplication.sharedApplication().networkActivityIndicatorVisible = true
                let request = Request.getRequestWith("GET", strURL: url, parameters: nil)
                
                let session = NSURLSession.sharedSession()
                let dataTask = session.dataTaskWithRequest(request, completionHandler: { (data, response, error) -> Void in
                    
                    UIApplication.sharedApplication().networkActivityIndicatorVisible = false
                    
                    dispatch_async(dispatch_get_main_queue()) {
                        self.contentMode = contentMode
                        if let data = data {
                            if let image = UIImage(data: data) {
                                self.image = image
                                Cache.sharedInstance.setObject(image, forKey: url)
                            }
                            
                        }
                    }
                })
                dataTask.resume()
//            }
        }
        
        
        
    }
}


