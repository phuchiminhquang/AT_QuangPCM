//
//  InfoController.swift
//  Bai 2
//
//  Created by Quang Phu on 6/23/16.
//  Copyright © 2016 Quang Phu. All rights reserved.
//

import UIKit

class InfoController: UIViewController {

    @IBOutlet weak var lbInfomation: UILabel!
    
    var username = ""
    var password = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       self.lbInfomation.text = "Hello \(self.username)"
    }
    
    func setUsernameAndPassword(username: String, password: String) {
        self.username = username
        self.password = password
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
   
    @IBAction func logout(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
}
