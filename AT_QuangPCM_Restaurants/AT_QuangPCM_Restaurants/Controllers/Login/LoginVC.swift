//
//  LoginVC.swift
//  AT-QuangPCM
//
//  Created by Quang Phu on 7/11/16.
//  Copyright © 2016 demo. All rights reserved.
//

import UIKit

private extension Selector {
    static let keyboardWillShow = #selector(LoginVC.keyboardWillShow(_:))
    static let keyboardWillHide = #selector(LoginVC.keyboardWillHide(_:))
}

class LoginVC: ViewController {

    // MARK: IBOutlet
    @IBOutlet private weak var verticalspace_superview_buttom_and_bt_login_with_twiter: NSLayoutConstraint!
    @IBOutlet private weak var verticalSpace_email_top_and_login_bottom: NSLayoutConstraint!
    @IBOutlet private weak var top_bg_top_constraint: NSLayoutConstraint!
    @IBOutlet private weak var bg_top_imageView: UIImageView!
    @IBOutlet private weak var login_Email: UITextField!
    @IBOutlet weak var login_Password: UITextField!
    
    // Sign up View
    @IBOutlet private weak var signUpView: UIView!
    @IBOutlet private weak var signUpSubView: UIView!
    @IBOutlet private weak var signUp_photo: UIButton!
    @IBOutlet private weak var signUp_Name: UITextField!
    @IBOutlet private weak var signUp_Email: UITextField!
    @IBOutlet private weak var signUp_Password: UITextField!
    @IBOutlet private weak var signUp_ConfirmPassword: UITextField!

    
    
    // MARK: Property
    private var activeTextfield = UITextField()
    private var imageURL: NSURL?
    
    
    // MARK: Init View
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        if UIScreen.mainScreen().bounds.size.height == 480 {
            self.top_bg_top_constraint.constant = -60
            self.verticalSpace_email_top_and_login_bottom.constant = 5
            self.verticalspace_superview_buttom_and_bt_login_with_twiter.constant = 5
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
   
    
    // MARK: private function
    override func loadData() {
        
    }
    
    override func configuartionUI() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: .keyboardWillShow, name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: .keyboardWillHide, name: UIKeyboardWillHideNotification, object: nil)
        
        self.signUpSubView.border(5.0, width: 2, color: MyColor.borderGrayColor)
        self.signUp_photo.addRightBorderWithColor(MyColor.borderGrayColor, andWidth: 1)
        self.signUp_Name.addBottomBorderWithColor(MyColor.borderGrayColor, andWidth: 1)
        self.signUp_Password.addTopBorderWithColor(MyColor.borderGrayColor, andWidth: 1)
        self.signUp_Password.addBottomBorderWithColor(MyColor.borderGrayColor, andWidth: 1)
        self.signUp_ConfirmPassword.addBottomBorderWithColor(MyColor.borderGrayColor, andWidth: 1)
        
    }
    
    override func getImageFromCamera() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) {
            let imagePickerViewController = getImagePickerViewController(.Camera)
            self.presentViewController(imagePickerViewController, animated: true, completion: nil)
        } else {
            let errorMessage = UIAlertController(title: "Warning", message: "The Camera doesn't support on this device", preferredStyle: .Alert)
            errorMessage.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler: nil))
            self.presentViewController(errorMessage, animated: true, completion: nil)
        }
    }
    
    override func getImageFromLibrary() {
        let imagePickerViewController = getImagePickerViewController(.PhotoLibrary)
        self.presentViewController(imagePickerViewController, animated: true, completion: nil)

    }
    
    private func getImagePickerViewController(sourceType: UIImagePickerControllerSourceType) -> UIImagePickerController {
        let imagePickerViewController = UIImagePickerController()
        imagePickerViewController.delegate = self
        imagePickerViewController.allowsEditing = true
        imagePickerViewController.sourceType = sourceType
        return imagePickerViewController
    }
    
    
    
    // MARK: Keyboard Notification
    func keyboardWillShow(notification: NSNotification) {
        adjustingHeight(true,notification: notification)
    }
    
    func keyboardWillHide(notification: NSNotification) {
        adjustingHeight(false,notification: notification)
    }
    
    func adjustingHeight(show: Bool,notification: NSNotification) {
        let screenFrame = UIScreen.mainScreen().bounds
        var userinfo = notification.userInfo!
        
        let keyboardFrame: CGRect = (userinfo[UIKeyboardFrameBeginUserInfoKey] as! NSValue).CGRectValue()
        let animationDuration = userinfo[UIKeyboardAnimationDurationUserInfoKey] as! NSTimeInterval
        
        let ySubView = self.signUpSubView.frame.origin.y + self.signUpView.frame.origin.y
        let value = screenFrame.height - (( activeTextfield.frame.origin.y + activeTextfield.bounds.size.height) + ySubView) - self.view.frame.origin.y
        let changeInHeight = (CGRectGetHeight(keyboardFrame) - value) * (show ? -1 : 1)
        
//        print("ySubView\(ySubView)  value\(value)  changeInHeight\(changeInHeight)  keyboardgheight: \(CGRectGetHeight(keyboardFrame))")
        
        if value < CGRectGetHeight(keyboardFrame) && show  || self.view.frame.origin.y < 0 && !show {
            UIView.animateWithDuration(animationDuration, animations: { () -> Void in
                self.view.frame.origin.y += changeInHeight
            })
        }
    }
    
    // MARK: touch event
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
        self.view.frame.origin.y = 0
    }
    
    // MARK: IBAction
    @IBAction func didTapLogIn(sender: AnyObject) {
        self.view.endEditing(true)
        
        self.bg_top_imageView.image = UIImage(named: "bg_top_login")
        
        self.signUpView.alpha = 1
        UIView.animateWithDuration(0.5, animations: {
            self.signUpView.alpha = 0.0
        }) { (finished) in
            self.signUpView.hidden = true
        }
    }
    
    @IBAction func checkLogin(sender: AnyObject) {
        if (self.login_Email.text!.isValid(.Email) || self.login_Email.text != "") && self.login_Password.text != "" {
            let name = self.login_Email.text!
            let email = self.login_Email.text!
            let password = self.login_Password.text!
            
            let user = User(name: name, email: email, password: password, photo: nil)
            if user.isUserExisted() {
                print("welcome \(user.name)")
                AppDelegate.appDelegate.loginSuccess()
            } else {
                print("Sorry, User is not correct")
            }
        }
    }
    
    @IBAction func didTapSignUp(sender: AnyObject) {
        self.view.endEditing(true)
        
        self.bg_top_imageView.image = UIImage(named: "bg_top_signup")
        
        self.signUpView.hidden = false
        UIView.animateWithDuration(0.5) {
            self.signUpView.alpha = 1
        }
    }
    
    
    @IBAction func didTapSignUpButton(sender: AnyObject) {
        if (self.signUp_Email.text!.isValid(.Email)) || self.signUp_Name.text != "" {
            if self.signUp_Password.text != self.signUp_ConfirmPassword.text {
                self.showAlertMessage(Strings.alertActionWarningTitle, message: Strings.messagePasswordNotMatch)
            } else { // Save user data into plist file
                
                let imageUrlStr = String(self.imageURL!)
                let newUser = ["name" : self.signUp_Name.text!,
                               "password": self.signUp_Password.text!,
                               "photo": imageUrlStr]
                //1
                if let plist = Plist(name: "Users") {
                    //2
                    let dict = plist.getMutablePlistFile()!
                    dict[self.signUp_Email.text!] = newUser
                    
                    do {
                        try plist.addValuesToPlistFile(dict)
                    } catch {
                        print(error)
                    }
                    plist.copyIntoSourcePath()
                    
                    //4
                    print(plist.getValuesInPlistFile())
                } else {
                    print("Unable to get Plist")
                }

            }
    
        }
    }
    
    
    @IBAction func didTapChoosePhoto(sender: AnyObject) {
        showAlertControllerToChoosePhoto()
    }
    
    
    @IBAction func didTapForgotPassword(sender: AnyObject) {
        let alertController = UIAlertController(title: "Enter your email", message: nil, preferredStyle: .Alert)
        alertController.addTextFieldWithConfigurationHandler(nil)
        
        let submitAction = UIAlertAction(title: "Submit", style: .Default) { [unowned self, alertController] (action: UIAlertAction!) in
            let email = alertController.textFields![0] as! UITextField
    
            
            //1
            if let plist = Plist(name: "Users") {
                //2
                let dict = plist.getValuesInPlistFile()!
                print(dict)
                
                if let user = dict.objectForKey(email.text!) {
                    let password = user["password"] as! String
                    self.showAlertMessage("Forgot password", message: "Your password is \(password)")
                } else {
                    self.showAlertMessage("Warning", message: "Your email is not correct")
                }
                
                print(plist.getValuesInPlistFile())
            } else {
                print("Unable to get Plist")
            }

            
            // do something interesting with "answer" here
        }
        
        alertController.addAction(submitAction)
        
        presentViewController(alertController, animated: true, completion: nil)
    }
    
}

extension LoginVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        let nextTag: NSInteger = textField.tag
        // Try to find next responder
        if nextTag != 1 && nextTag != 5{
            if let txtField1 = self.view.viewWithTag(nextTag + 1) as? UITextField {
                txtField1.becomeFirstResponder()
            }
        } else {
            // Not found, so remove keyboard.
            textField.resignFirstResponder()
            UIView.animateWithDuration(0.5, animations: { () -> Void in
                self.view.frame.origin.y = 0
            })
        }
        return true
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        activeTextfield = textField
        switch textField.tag {
        case 0,2,3,4:
            textField.returnKeyType = UIReturnKeyType.Next
        case 1, 5:
            textField.returnKeyType = UIReturnKeyType.Default
        default:
            break
        }
    }
}

extension LoginVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
//    
//    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
//        
//    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        
        let pickedImage:UIImage
        
        if let info = editingInfo, let editedImage = info[UIImagePickerControllerEditedImage] as? UIImage {
            pickedImage = editedImage
        } else {
            pickedImage = image
        }
        
        self.signUp_photo?.setBackgroundImage(pickedImage, forState: .Normal)
        
        let randomStringForAvatarImage = randomStringWithLength(5) as String
        
        let fileManager = NSFileManager.defaultManager()
        let rootPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
        let filePath = "\(rootPath)/\(randomStringForAvatarImage).jpg"
//        let savedImage = compressForUpload(pickedImage, withHeightLimit: 500, andWidthLimit: 500)
        let imageData = UIImageJPEGRepresentation(pickedImage, 1.0)
        fileManager.createFileAtPath(filePath, contents: imageData, attributes: nil)
        
        if (fileManager.fileExistsAtPath(filePath)) {
            self.imageURL = NSURL.init(fileURLWithPath: filePath)
        }
        
        picker.dismissViewControllerAnimated(true, completion: nil)
        
    }
}





