//
//  AppDelegate.swift
//  ATDemo
//
//  Created by AsianTech on 7/11/16.
//  Copyright © 2016 demo. All rights reserved.
//

import UIKit

let kAppDelegate = UIApplication.sharedApplication().delegate as? AppDelegate

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    static let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    var tabbarController = UITabBarController()
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        if let window = window {
            let login = LoginVC.loadViewControllerFromNib()
            let loginNavi = UINavigationController(rootViewController: login)
            self.window?.rootViewController = loginNavi
            window.backgroundColor = UIColor.whiteColor()
            window.makeKeyAndVisible()
        }
        return true
    }

    func loginSuccess() {
        if let window = window {
            self.window?.rootViewController = BaseTabbarController()
            window.backgroundColor = UIColor.whiteColor()
            window.makeKeyAndVisible()
        }
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

