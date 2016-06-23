//
//  RootController.swift
//  Bai 1
//
//  Created by Quang Phu on 6/23/16.
//  Copyright © 2016 Quang Phu. All rights reserved.
//

import UIKit

class RootController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var lbMessage: UILabel!
    
    @IBOutlet weak var btnSubmit: UIButton!
    
    @IBOutlet weak var tfUsername: UITextField!
    
    @IBOutlet weak var tfPassword: UITextField!
    
    var activeTextfield = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tfUsername.delegate = self
        self.tfPassword.delegate = self
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(RootController.keyboardWillShow(_:)), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(RootController.keyboardWillHide(_:)), name: UIKeyboardWillHideNotification, object: nil)
        
        
    }
    
    //Keyboard Notification
    func keyboardWillShow(notification: NSNotification) {
        adjustingHeight(true,notification: notification)
    }
    
    func keyboardWillHide(notification: NSNotification) {
        adjustingHeight(false,notification: notification)
    }
    
    func adjustingHeight(show: Bool,notification: NSNotification) {
        
        var userinfo = notification.userInfo!
        
        let keyboardFrame: CGRect = (userinfo[UIKeyboardFrameBeginUserInfoKey] as! NSValue).CGRectValue()
        let animationDuration = userinfo[UIKeyboardAnimationDurationUserInfoKey] as! NSTimeInterval
        
        let screenFrame = UIScreen.mainScreen().bounds
        
        let value = screenFrame.height - (CGRectGetMaxY(activeTextfield.frame) + CGRectGetHeight(activeTextfield.frame))
        let changeInHeight = (CGRectGetHeight(keyboardFrame) - value) * (show ? -1 : 1)
        
        if value < CGRectGetHeight(keyboardFrame) && show  || self.view.frame.origin.y < 0 && !show {
            
            UIView.animateWithDuration(animationDuration, animations: { () -> Void in
                self.view.frame.origin.y += changeInHeight
            })
        }
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        activeTextfield = textField
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    @IBAction func login(sender: AnyObject) {
        if self.tfUsername.text?.characters.count == 0 || self.tfPassword.text?.characters.count == 0{
            let alert = UIAlertController(title: "Warning", message: "Username or Password is empty", preferredStyle:UIAlertControllerStyle.Alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
            alert.addAction(defaultAction)
            
            self.presentViewController(alert, animated: true, completion: nil)
        } else {
            let infoController = InfoController(nibName: "InfoController", bundle: nil)
            self.navigationController?.pushViewController(infoController, animated: true)
            
            infoController.setUsernameAndPassword(self.tfUsername.text!, password: self.tfPassword.text!)
        }
    }
    
}
