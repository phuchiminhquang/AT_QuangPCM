//
//  HomeVC.swift
//  AT-QuangPCM
//
//  Created by Quang Phu on 7/13/16.
//  Copyright © 2016 demo. All rights reserved.
//

import UIKit

class HomeVC: UIViewController {

    
    @IBOutlet private weak var restaurantTableView: UITableView!
    
    // MARK: private
    var datasource: NSDictionary?
    var restaurantNames = [String]()
    var restaurants: [Restaurant]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Home"
        self.datasource = nil
        self.loadData()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    
    }
    
    override func viewWillAppear(animated: Bool) {
        
    }
    
    // MARK: private function
    func loadData() {
        if let plist = Plist(name: "Restaurants") {
//            if let datasource = plist.getValuesInPlistFile() {
//                self.datasource = datasource
//            }
            self.datasource = plist.getValuesInPlistFile()
            if let datasource = self.datasource {
                self.fllDatasourceIntoArray(datasource)
            }
            print(self.datasource!)
        }
        
        
        // Register xib flie for TableViewCell
        let nib = UINib(nibName: Strings.restaurantCellIdentified, bundle: nil)
        self.restaurantTableView.registerNib(nib, forCellReuseIdentifier: Strings.restaurantCellIdentified)
    }
    
    
    func fllDatasourceIntoArray(datasource:NSDictionary) {
        restaurantNames = datasource.allKeys as? [String] ?? []
        restaurants = [Restaurant]()
        //            for (key, value) in datasource.enumerate() as? (String,NSDictionary) {
        //                let res: Restaurant = Restaurant()
        //                res.name = String(key)
        //                res.photo = value["photo"] as? String ?? "no_picture"
        //
        //            }
        for i in 0..<datasource.count {
            let resObj = datasource.objectForKey(restaurantNames[i]) as? NSDictionary
            if let resObj = resObj {
                let res = Restaurant()
                
                res.name = restaurantNames[i]
                res.photo = resObj["photo"] as? String ?? "no_pictrue"
                res.address = resObj["address"] as? String ?? "no address"
                res.longDes = resObj["longDes"] as? String ?? "no longDes"
                res.shortDes = resObj["shortDes"] as? String ?? "no shortDes"
                res.latitue = resObj["latitue"] as? Double ?? 0.0
                res.longtitue = resObj["longtitue"] as? Double ?? 0.0
                
                if let menu = resObj.objectForKey("menus") as? NSArray {
                    var foodPhotos = [String]()
                    for item in menu {
                        foodPhotos.append(item as? String ?? "no_pictrue")
//                        print("da append")
                    }
                    res.food?.append(Food(name: nil, des: nil, photo: foodPhotos))
                }
                
                res.rating = resObj["rating"] as? Int ?? 0
                res.isFavoratie = resObj["favorite"] as? Bool ?? false
                restaurants?.append(res)
                
            }
        }
    }
}


extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = self.restaurants?.count {
            print("\(count)")
            return count
        }
        return 0
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(Strings.restaurantCellIdentified, forIndexPath: indexPath) as? RestaurantCell
        
        let photo = self.restaurants?[indexPath.row].photo ?? "no_picture"
        let name = self.restaurants?[indexPath.row].name ?? "no name"
        
        cell?.restaurantPhoto.image = UIImage(named: photo)
        cell?.restaurantName.text = name
        cell?.accessoryType = .DisclosureIndicator
        cell?.selectionStyle = UITableViewCellSelectionStyle.None
        
        return cell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let detail = RestaurantDetailVC(nibName: "RestaurantDetailVC", bundle: nil)
        if let restaurant = self.restaurants?[indexPath.row] {
            detail.setupData(restaurant)
            print("\(restaurant.food?[0].photo?.count)")
        }
        self.navigationController?.pushViewController(detail, animated: true)
    }
}



















