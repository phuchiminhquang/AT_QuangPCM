//
//  RootController.swift
//  Bai 2
//
//  Created by Quang Phu on 7/6/16.
//  Copyright © 2016 Quang Phu. All rights reserved.
//

import UIKit

class RootController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: IBOutlet & IBAction
    @IBOutlet weak var myTableVew: UITableView!
    
    
    // MARK: Property
    let names = ["Nguyen Van A","Nguyen Van B","Nguyen Van C","Nguyen Van D","Nguyen Van E","Le Thi Meo",
                 "Le Thi Mui","Le Thi Ti","Tran Suu","Mau","Le Thi X", "Ba Van Y","Nguyen Van A","Nguyen Van B","Nguyen Van C","Nguyen Van D","Nguyen Van E","Le Thi Meo",
                 "Le Thi Mui","Le Thi Ti","Tran Suu","Mau","Le Thi X", "Ba Van Y","Nguyen Van A","Nguyen Van B","Nguyen Van C","Nguyen Van D","Nguyen Van E","Le Thi Meo",
                 "Le Thi Mui","Le Thi Ti","Tran Suu","Mau","Le Thi X", "Ba Van Y","Nguyen Van A","Nguyen Van B","Nguyen Van C","Nguyen Van D","Nguyen Van E","Le Thi Meo",
                 "Le Thi Mui","Le Thi Ti","Tran Suu","Mau","Le Thi X", "Ba Van Y"]
//    let cellIdentifier = "CustomCell"
    
    
    // MARK: Init View
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let nib = UINib(nibName: "CustomTableViewCell", bundle: nil)
//        myTableVew.registerNib(nib, forCellReuseIdentifier: cellIdentifier)
    }
    
    override func viewWillAppear(animated: Bool) {
        
    }
    
    override func viewDidAppear(animated: Bool) {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    // MARK: private function
    
    // MARK: UITableViewDataSource
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        

        let cell: UITableViewCell? = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "CustomCell")
        
        cell?.textLabel?.text = names[indexPath.row]
        cell?.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        
        return cell!
    }
}
