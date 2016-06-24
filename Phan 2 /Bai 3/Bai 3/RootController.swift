//
//  RootController.swift
//  Bai 3
//
//  Created by Quang Phu on 6/24/16.
//  Copyright © 2016 Quang Phu. All rights reserved.
//

import UIKit

class RootController: UIViewController {

    // MARK: outlet
    
    @IBOutlet weak var lbCurrentTime: UILabel!
    
    // MARK: action
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       updateTime()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
    // MARK: private function
    func getCurrentDateTime(formatString: String) -> String {
        
        var todayString = ""
        // 1 Get date
        let today = NSDate()
        
        let dateFormat = NSDateFormatter()
        // 2 Set the current locale
        dateFormat.locale = NSLocale.currentLocale()
        dateFormat.dateFormat = formatString
        
        todayString = dateFormat.stringFromDate(today)
        
        return todayString
    }
    
    func updateTime(){
        let formatString = "EEEE, dd-MMMM-yyyy HH:mm:ss"
        let updatedDate = getCurrentDateTime(formatString)
        
        // Update content of lb
        self.lbCurrentTime.text = updatedDate
    }
    
    
    // MARK: touch
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        updateTime()
    }
}
