//
//  HomeViewController.swift
//  BaiTap2
//
//  Created by Quang Phu on 6/22/16.
//  Copyright © 2016 Quang Phu. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController , UITextFieldDelegate {

    @IBOutlet weak var mytextfield: UITextField!
    @IBOutlet weak var myLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mytextfield.delegate = self
        myLabel.text = "xyz"
        // Do any additional setup after loading the view.
    }
    
//    func textFieldDidEndEditing(textField: UITextField) {
//        myLabel.text = "abc"
//    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
    
        print(string)
        
        let newString = (textField.text! as NSString).stringByReplacingCharactersInRange(range, withString: string)

        print(newString)
        
        if newString.characters.count < 120 {
            myLabel.text = String(newString.characters.count)
            return true
        } else {
            return false
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
