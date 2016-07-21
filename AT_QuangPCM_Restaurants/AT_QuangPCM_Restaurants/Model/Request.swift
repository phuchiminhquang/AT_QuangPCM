//
//  Request.swift
//  ParseJsonBasic
//
//  Created by Asiantech1 on 7/18/16.
//  Copyright © 2016 Asiantech1. All rights reserved.
//

import Foundation

class Request {
    
    static func getRequestWith(method: String, strURL: String?, parameters: NSDictionary?) -> NSURLRequest {

        var request = NSMutableURLRequest()
        var url: NSURL!
        
        if let parameters = parameters {
            let limit = parameters.objectForKey("limit") as? Int ?? 0
            let offset = parameters.objectForKey("offset") as? Int ?? 0
            let basicURL = Strings.prefixURL +  "limit=" + String(limit) + "&offset=" + String(offset)
            print("basicURL: \(basicURL)")
            url = NSURL(string: basicURL)
        }
        if let strURL = strURL {
            url = NSURL(string: strURL)
        }
        if let url = url {
            request = NSMutableURLRequest(URL: url,
                                              cachePolicy: .UseProtocolCachePolicy,
                                              timeoutInterval: 10.0)
            request.HTTPMethod = method
            request.allHTTPHeaderFields = parameters as? [String : String]
        }
        return request
    }
}