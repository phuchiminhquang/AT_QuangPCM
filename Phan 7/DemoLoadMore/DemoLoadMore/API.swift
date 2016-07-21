//
//  API.swift
//  ParseJsonBasic
//
//  Created by Asiantech1 on 7/19/16.
//  Copyright © 2016 Asiantech1. All rights reserved.
//

import UIKit

typealias APIComplete = (data : NSData?, error: Bool, message: String!) -> Void
typealias APICompletionHanlde = (items : [Cell]?, error: Bool, message: String!) -> Void
typealias APIDownloadImage = (image : UIImage?, error: Bool) -> Void

class API: NSObject {
    
    
    class var sharedInstance: API {
        struct Static {
            static var onceToken: dispatch_once_t = 0
            static var instance: API? = nil
        }
        dispatch_once(&Static.onceToken) {
            Static.instance = API()
        }
        return Static.instance!
    }
    
    
    func connect(request: NSURLRequest, complete: APICompletionHanlde) {
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            // do your task
            UIApplication.sharedApplication().networkActivityIndicatorVisible = true
            
            let session = NSURLSession.sharedSession()
            let dataTask = session.dataTaskWithRequest(request, completionHandler: { (data, response, error) -> Void in
                
                UIApplication.sharedApplication().networkActivityIndicatorVisible = false
                
                    // update some UI
                    if (error != nil) {
                        dispatch_async(dispatch_get_main_queue()) {
                            complete(items: nil, error: true, message: "")
                        }
                    } else {
                        var items = [Cell]()
                        do {
                            if let json = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as? NSDictionary {
                                if let data = json.objectForKey("data") as? NSDictionary {
                                    if let images = data.objectForKey("images") as? NSArray {
                                        for image in images {
                                            let item = Cell.convertToObject(image as! NSDictionary)
                                            items.append(item)
                                        }
                                    }
                                }
                            }
                            dispatch_async(dispatch_get_main_queue()) {
                                complete(items: items, error: false, message: "")
                            }
                        } catch {
                        }
                    }
            })
            dataTask.resume()
        }
    }
}
