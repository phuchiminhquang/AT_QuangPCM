//
//  plist.swift
//  AT-QuangPCM
//
//  Created by Quang Phu on 7/12/16.
//  Copyright © 2016 demo. All rights reserved.
//

import Foundation

struct Plist {
    //1
    enum PlistError: ErrorType {
        case FileNotWritten
        case FileDoesNotExist
    }
    //2
    var name:String
    //3
    var sourcePath:String? {
        guard let path = NSBundle.mainBundle().pathForResource(name, ofType: "plist") else { return .None }
        return path
    }
    //4
    var destPath:String? {
        guard sourcePath != .None else { return .None }
        let dir = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0]
        return (dir as NSString).stringByAppendingPathComponent("\(name).plist")
    }
    
    init?(name:String) {
        //1
        self.name = name
        //2
        let fileManager = NSFileManager.defaultManager()
        //3
        guard let source = sourcePath else { return nil }
        guard let destination = destPath else { return nil }
        guard fileManager.fileExistsAtPath(source) else { return nil }
        //4
        if !fileManager.fileExistsAtPath(destination) {
            //5
            do {
                try fileManager.copyItemAtPath(source, toPath: destination)
            } catch let error as NSError {
                print("Unable to copy file. ERROR: \(error.localizedDescription)")
                return nil
            }
        }
    }
    
    
    //1
    func getValuesInPlistFile() -> NSDictionary?{
        let fileManager = NSFileManager.defaultManager()
        if fileManager.fileExistsAtPath(sourcePath!) {
            guard let dict = NSDictionary(contentsOfFile: sourcePath!) else { return .None }
            return dict
        } else {
            return .None
        }
    }
    //2
    func getMutablePlistFile() -> NSMutableDictionary?{
        let fileManager = NSFileManager.defaultManager()
        if fileManager.fileExistsAtPath(destPath!) {
            guard let dict = NSMutableDictionary(contentsOfFile: destPath!) else { return .None }
            return dict
        } else {
            return .None
        }
    }
    //3
    func addValuesToPlistFile(dictionary: NSDictionary) throws {
        let fileManager = NSFileManager.defaultManager()
        if fileManager.fileExistsAtPath(destPath!) {
            if !dictionary.writeToFile(destPath!, atomically: false) {
                print("File not written successfully")
                throw PlistError.FileNotWritten
            }
        } else {
            throw PlistError.FileDoesNotExist
        }
    }
    
    func copyIntoSourcePath() -> String? {
 
        let fileManager = NSFileManager.defaultManager()
        
        guard let source = sourcePath else { return nil }
        guard let destination = destPath else { return nil }
        guard fileManager.fileExistsAtPath(destination) else { return nil }
        //4
        if !fileManager.fileExistsAtPath(source) {
            //5
            do {
                try fileManager.copyItemAtPath(destination, toPath: source)
            } catch let error as NSError {
                print("Unable to copy file. ERROR: \(error.localizedDescription)")
                return nil
            }
        } else {
            do {
                try fileManager.removeItemAtPath(source)
                try fileManager.copyItemAtPath(destination, toPath: source)
            }
            catch let error as NSError {
                print("Ooops! Something went wrong: \(error)")
            }
        }
        return ""
    }

}
