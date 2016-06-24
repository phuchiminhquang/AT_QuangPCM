//
//  RootController.swift
//  Bai 4
//
//  Created by Quang Phu on 6/24/16.
//  Copyright © 2016 Quang Phu. All rights reserved.
//

import UIKit

class RootController: UIViewController {

    // MARK: outlet

    @IBOutlet weak var lbMessage: UILabel!
    @IBOutlet weak var lbCurrentTime: UILabel!
    
    // MARK: action
    var isUpdate: Bool = true
    var timer = NSTimer()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(RootController.updateTime), userInfo: nil, repeats: true)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        let formatString = "HH:mm:ss"
        let updatedDate = getCurrentDateTime(formatString)
        
        // Update content of lb
        self.lbCurrentTime.text = updatedDate
    }
    
    
    func stratUpdate() {
        
    }
    
    func stopUpdate() {
        
    }
    
    // MARK: touch
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        if isUpdate {
            self.timer.invalidate()
            self.lbMessage.text = "Tag onto screen again to continute"
            isUpdate = false
        } else {
            timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(RootController.updateTime), userInfo: nil, repeats: true)
            self.lbMessage.text = "Tag onto screen again to stop"
            isUpdate = true
        }
    }

}
