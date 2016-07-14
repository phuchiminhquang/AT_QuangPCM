//
//  RootController.swift
//  TimeInterval
//
//  Created by Quang Phu on 7/14/16.
//  Copyright © 2016 Quang Phu. All rights reserved.
//

import UIKit

class RootController: UIViewController {

    // MARK: IBOutlet
    
    @IBOutlet private weak var currentTimeTF: UITextField!
    @IBOutlet private weak var pastTimeTF: UITextField!
    @IBOutlet private weak var timeIntervalTF: UITextField!
    @IBOutlet private weak var datatimePickerView: UIDatePicker!
    @IBOutlet private weak var messageTF: UILabel!
    
    // MARK: Property
    private var currentTime = NSDate()
    private var pastTime: NSDate? = nil
    private let dateFormatter = NSDateFormatter()
    
    // MARK: Init View
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadDate()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
    
    // MARK: private function
    private func loadDate() {
        dateFormatter.dateFormat = Strings.dataFormat
        self.currentTimeTF.text = dateFormatter.stringFromDate(self.currentTime)
    }
    
    private func configurationUI() {
        
    }
    
    private func convertToShortTimeInterval(intervalTime: String) -> String {
        var shortTime = ""
        var count = 0
        let componentTimes = intervalTime.componentsSeparatedByString(",")
        for item in componentTimes {
            if count < 2 {
                shortTime += item; count += 1
            }
        }
        return shortTime + " ago"
    }
    
    // MARK: IBAction
    @IBAction func didTapCalculateITimeInterval(sender: AnyObject) {
        let selectedTime = self.datatimePickerView.date
        self.pastTimeTF.text = self.dateFormatter.stringFromDate(selectedTime)
        
        if selectedTime.compare(currentTime) == NSComparisonResult.OrderedAscending {
            self.messageTF.text = ""
            let dateComponentsFormatter = NSDateComponentsFormatter()
            dateComponentsFormatter.unitsStyle = NSDateComponentsFormatterUnitsStyle.Full
            
            let interval = currentTime.timeIntervalSinceDate(selectedTime)
            
            let timeinterval = dateComponentsFormatter.stringFromTimeInterval(interval)
            
            if let timeinterval = timeinterval {
                print("FullTime: \(timeinterval)")
                self.timeIntervalTF.text = self.convertToShortTimeInterval(timeinterval)
            }
        } else {
            self.messageTF.text = "Choose a time in the past. Please"
            self.timeIntervalTF.text = "" 
        }
    }
    
    
    
}
