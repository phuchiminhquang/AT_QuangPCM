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
            restaurantNames = self.datasource?.allKeys as? [String] ?? []
            
            print(self.datasource!)
        }
        
//        //1
//        if let plist = Plist(name: "Users") {
//            //2
//            let dict = plist.getValuesInPlistFile()!
//            print(dict)
//            
//            if let user = dict.objectForKey(email.text!) {
//                let password = user["password"] as! String
//                self.showAlertMessage("Forgot password", message: "Your password is \(password)")
//            } else {
//                self.showAlertMessage("Warning", message: "Your email is not correct")
//            }
//            
//            print(plist.getValuesInPlistFile())
//        } else {
//            print("Unable to get Plist")
//        }
//    }
        
        
        // Register xib flie for TableViewCell
        let nib = UINib(nibName: Strings.restaurantCellIdentified, bundle: nil)
        self.restaurantTableView.registerNib(nib, forCellReuseIdentifier: Strings.restaurantCellIdentified)
    }
}


extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = self.datasource?.count {
            print("\(count)")
            return 200
        }
        return 0
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(Strings.restaurantCellIdentified, forIndexPath: indexPath) as? RestaurantCell
        let photo = self.datasource?[restaurantNames[indexPath.row % 5]]?["photo"] ?? "nophoto"
        let name = restaurantNames[indexPath.row % 5]
        
        cell?.restaurantPhoto.image = UIImage(named: photo as! String)
        cell?.restaurantName.text = name
        
        return cell!
        
    }
}
