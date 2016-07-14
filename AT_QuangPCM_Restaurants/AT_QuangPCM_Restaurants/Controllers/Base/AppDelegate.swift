//
//  AppDelegate.swift
//  ATDemo
//
//  Created by AsianTech on 7/11/16.
//  Copyright © 2016 demo. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    static let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    var tabbarController = UITabBarController()
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        
        self.configTabbarController()
        
//        if let window = window {
//            let root = LoginVC(nibName: "LoginVC", bundle: nil)
////            let navi = UINavigationController(rootViewController: root)
//            self.window?.rootViewController = root
//            window.backgroundColor = UIColor.whiteColor()
//            window.makeKeyAndVisible()
//        }
        
        
        if let window = window {
            self.window?.rootViewController = tabbarController
            window.backgroundColor = UIColor.whiteColor()
            window.makeKeyAndVisible()
        }
        
        return true
    }

    func loginSuccess() {
        
        if let window = window {
            self.window?.rootViewController = tabbarController
            window.backgroundColor = UIColor.whiteColor()
            window.makeKeyAndVisible()
        }
    }
    
    func configTabbarController() {
        let homeVC = HomeVC(nibName: "HomeVC", bundle: nil)
        let favoriteVC = FavoriteVC(nibName: "FavoriteVC", bundle: nil)
        let mapVC = MapVC(nibName: "FavoriteVC", bundle: nil)
        let settingVC = SettingVC(nibName: "FavoriteVC", bundle: nil)
        
        let homeNavi = UINavigationController(rootViewController: homeVC)
        let favoriteNavi = UINavigationController(rootViewController: favoriteVC)
        let mapNavi = UINavigationController(rootViewController: mapVC)
        let settingNavi = UINavigationController(rootViewController: settingVC)
        
        let homeItem = UITabBarItem(title: "Home", image: UIImage(named: "ic_tbItem_home"), selectedImage: UIImage(named: ""))
        let favoriteItem = UITabBarItem(title: "Favorite", image: UIImage(named: "ic_tbItem_favorite"), selectedImage: UIImage(named: ""))
        let mapItem = UITabBarItem(title: "Map", image: UIImage(named: "ic_tbItem_map"), selectedImage: UIImage(named: ""))
        let settingItem = UITabBarItem(title: "Setting", image: UIImage(named: "ic_tbItem_setting"), selectedImage: UIImage(named: ""))
        
        homeVC.tabBarItem = homeItem
        favoriteVC.tabBarItem = favoriteItem
        mapVC.tabBarItem = mapItem
        settingVC.tabBarItem = settingItem
        
        // Create Tabbar
        tabbarController.viewControllers = [homeNavi,favoriteNavi,mapNavi,settingNavi]
        tabbarController.tabBar.tintColor = MyColor.tabBarTintColor
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

