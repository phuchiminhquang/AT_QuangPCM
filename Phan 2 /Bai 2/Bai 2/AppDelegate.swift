//
//  AppDelegate.swift
//  Bai 2
//
//  Created by Quang Phu on 6/23/16.
//  Copyright © 2016 Quang Phu. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        
        if let window = window {
            let root = RootController(nibName: "RootController", bundle: nil)
            window.rootViewController = root
            
            window.backgroundColor = UIColor.whiteColor()
            window.makeKeyAndVisible()
        }

        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        
    }

    func applicationDidEnterBackground(application: UIApplication) {
       
    }

    func applicationWillEnterForeground(application: UIApplication) {
        
    }

    func applicationDidBecomeActive(application: UIApplication) {
            }

    func applicationWillTerminate(application: UIApplication) {
        
    }


}

