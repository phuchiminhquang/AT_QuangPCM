//
//  AppDelegate.swift
//  DemoLoadMore
//
//  Created by Asiantech1 on 7/21/16.
//  Copyright © 2016 Asiantech1. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        if let window = window {
            Cache.sharedInstance.removeAllObjects()
            let root = RootVC(nibName: "RootVC", bundle: nil)
            let loginNavi = UINavigationController(rootViewController: root)
            self.window?.rootViewController = loginNavi
            window.backgroundColor = UIColor.whiteColor()
            window.makeKeyAndVisible()
        }
        return true
    }


}

