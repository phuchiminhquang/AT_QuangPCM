//
//  API.swift
//  ParseJsonBasic
//
//  Created by Asiantech1 on 7/19/16.
//  Copyright © 2016 Asiantech1. All rights reserved.
//

import UIKit

typealias APIComplete = (data : NSData?, error: Bool, message: String!) -> Void
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
    
    
    var data = NSMutableData()
    var connection: NSURLConnection!
    
    
    func connect(request: NSURLRequest, complete: APIComplete) {
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            // do your task
            UIApplication.sharedApplication().networkActivityIndicatorVisible = true
            
            let session = NSURLSession.sharedSession()
            let dataTask = session.dataTaskWithRequest(request, completionHandler: { (data, response, error) -> Void in
                
                UIApplication.sharedApplication().networkActivityIndicatorVisible = false
                
                dispatch_async(dispatch_get_main_queue()) {
                    // update some UI
                    if (error != nil) {
                        complete(data: nil, error: true, message: error?.localizedDescription)
                    } else {
                        complete(data: data, error: false, message: "OK")
                    }
                }
            })
            dataTask.resume()
        }
    }
    
    func dowloadImage(photoPath: String, request: NSURLRequest , complete: APIDownloadImage) {
        if let image = Cache.sharedInstance.objectForKey(photoPath) as? UIImage  {
            dispatch_async(dispatch_get_main_queue()) {
                complete(image: image, error: false)
            }
        } else {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
                // do your task
                UIApplication.sharedApplication().networkActivityIndicatorVisible = true
                
                let session = NSURLSession.sharedSession()
                let dataTask = session.dataTaskWithRequest(request, completionHandler: { (data, response, error) -> Void in
                    
                    UIApplication.sharedApplication().networkActivityIndicatorVisible = false
                    
                    dispatch_async(dispatch_get_main_queue()) {
                        let image = UIImage(data: data!)
                        // update some UI
                        if (error == nil) {
                            complete(image: image, error: false)
                        } else {
                            complete(image: image, error: true)
                        }
                    }
                })
                dataTask.resume()
            }
        }
    }

    deinit {
        
    }

}
