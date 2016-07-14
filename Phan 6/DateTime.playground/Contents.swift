//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"


let dateFormatter = NSDateFormatter()

dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
var dateAsString = "2015-05-29 23:50:00"
var date1 = dateFormatter.dateFromString(dateAsString)!

dateAsString = "2016-03-30 01:00:0"
var date2 = dateFormatter.dateFromString(dateAsString)!

var diffDateComponents = NSCalendar.currentCalendar().components([NSCalendarUnit.Year, NSCalendarUnit.Month, NSCalendarUnit.Day, NSCalendarUnit.Hour, NSCalendarUnit.Minute, NSCalendarUnit.Second], fromDate: date1, toDate: date2, options: NSCalendarOptions.init(rawValue: 0))


print("The difference between dates is: \(diffDateComponents.year) years, \(diffDateComponents.month) months, \(diffDateComponents.day) days, \(diffDateComponents.hour) hours, \(diffDateComponents.minute) minutes, \(diffDateComponents.second) seconds")



let dateComponentsFormatter = NSDateComponentsFormatter()
dateComponentsFormatter.unitsStyle = NSDateComponentsFormatterUnitsStyle.Full

let interval = date2.timeIntervalSinceDate(date1)
dateComponentsFormatter.stringFromTimeInterval(interval)



//dateComponentsFormatter.allowedUnits = [NSCalendarUnit.Year, NSCalendarUnit.Month, NSCalendarUnit.Day, NSCalendarUnit.Hour, NSCalendarUnit.Minute, NSCalendarUnit.Second]
//let autoFormattedDifference = dateComponentsFormatter.stringFromDate(date1, toDate: date2)
//if let timeInterval = autoFormattedDifference {
//    print("\(timeInterval)")
//}


// Comparing time.
dateFormatter.dateFormat = "HH:mm:ss zzz"
dateAsString = "14:28:16 GMT"
date1 = dateFormatter.dateFromString(dateAsString)!

dateAsString = "19:53:12 GMT"
date2 = dateFormatter.dateFromString(dateAsString)!

if date1.earlierDate(date2) == date1 {
    if date1.isEqualToDate(date2) {
        print("Same time")
    }
    else {
        print("\(date1) is earlier than \(date2)")
    }
}
else {
    print("\(date2) is earlier than \(date1)")
}
