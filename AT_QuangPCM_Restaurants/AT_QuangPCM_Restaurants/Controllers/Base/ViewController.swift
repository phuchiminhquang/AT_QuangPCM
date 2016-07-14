//
//  ViewController.swift
//  AT-QuangPCM
//
//  Created by Quang Phu on 7/12/16.
//  Copyright © 2016 demo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadData()
        self.configuartionUI()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadData () {
        
    }
    
    func configuartionUI() {
        
    }
    
    func showAlertControllerToChoosePhoto() {
        let alertController = UIAlertController(title: Strings.alertControllerTitle, message: "", preferredStyle: .ActionSheet)
        alertController.addAction(UIAlertAction(title: Strings.alertActionCameraTitle, style: .Default, handler: { (finish) in
            self.getImageFromCamera()
            
        }))
        alertController.addAction(UIAlertAction(title: Strings.alertActionLibraryTitle, style: .Default, handler: { (finish) in
            self.getImageFromLibrary()
            
        }))
        alertController.addAction(UIAlertAction(title: Strings.alertActionCancelTitle, style: .Cancel, handler: nil))
        
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    func getImageFromCamera() {
       
    }
    
    func getImageFromLibrary() {
       
    }
    
    func randomStringWithLength (len : Int) -> NSString  {
        let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let randomString : NSMutableString = NSMutableString(capacity: len)
        for _ in 0...len {
            let length = UInt32 (letters.length)
            let rand = arc4random_uniform(length)
            randomString.appendFormat("%C", letters.characterAtIndex(Int(rand)))
        }
        return randomString
    }
    
    func showAlertMessage(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        alertController.addAction(UIAlertAction(title: Strings.alertActionOkeyTitle, style: .Cancel, handler: nil))
        self.presentViewController(alertController, animated: true, completion: nil)
    }
}
