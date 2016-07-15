//
//  BaseTabbarController.swift
//  AT_QuangPCM_Restaurants
//
//  Created by Asiantech1 on 7/15/16.
//  Copyright © 2016 Quang Phu. All rights reserved.
//

import UIKit

class BaseTabbarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configTabbarController()
      
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
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
        viewControllers = [homeNavi,favoriteNavi,mapNavi,settingNavi]
        tabBar.tintColor = MyColor.tabBarTintColor
    }

}
