//
//  DetailController.swift
//  Bai 4
//
//  Created by Quang Phu on 7/6/16.
//  Copyright © 2016 Quang Phu. All rights reserved.
//

import UIKit

protocol ProfileControllerDelegate {
    func updateStudentInfo(student: Student, atIndex index: Int)
}


class ProfileController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    @IBAction func showChangePhotoOption(sender: AnyObject) {
        let alertController = UIAlertController(title: "Choose Image Option", message: "", preferredStyle: .ActionSheet)
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: { (finished) in
            
        }))
        alertController.addAction(UIAlertAction(title: "Camera", style: .Default, handler: { (finished) in
            self.showCamera()
        }))
        alertController.addAction(UIAlertAction(title: "Library", style: .Default, handler: { (finished) in
            self.showPhotoFromLibrary()
        }))
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    // MARK: IBOutlet & IBAction
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var photoButton: UIButton!
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var ageTF: UITextField!
    @IBOutlet weak var genderSegmented: UISegmentedControl!
    @IBOutlet weak var ageDatePicker: UIDatePicker!
    
    
    // MARK: Property
    var isDetail = true
    var index = 0
    var delegate: ProfileControllerDelegate?
    weak var student: Student?
    
    var photoButtonSize: CGSize!

    // MARK: Init View
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Detail"
        
        self.photoButton.layer.cornerRadius = self.photoButton.frame.size.width / 2
        self.photoButton.clipsToBounds = true
        self.photoButton.setBackgroundImage(self.student!.photo, forState: .Normal)
        
        self.nameTF.text = self.student!.name
        self.ageTF.text = "\(self.student!.age)"
        self.genderSegmented.selectedSegmentIndex = self.student!.gender == "Female" ? 0 : 1
        
        
        if isDetail {
            self.ageTF.hidden = false
            self.ageDatePicker.hidden = true
            
        } else {
            self.ageTF.hidden = true
            self.ageDatePicker.hidden = false
        }
        
        // Create a bar button as image
        let button = UIButton(type: .Custom)
        button.frame = CGRectMake(0, 0, 30, 30)
        button.setBackgroundImage(UIImage(named: "edit.jpg"), forState: UIControlState.Normal)
        button.addTarget(self, action: #selector(ProfileController.editProfile), forControlEvents: UIControlEvents.TouchUpInside)
        
        let barButton = UIBarButtonItem(customView: button)
        self.navigationItem.rightBarButtonItem = barButton
        
    }
    
    override func viewWillAppear(animated: Bool) {
        
    }
    
    override func viewDidAppear(animated: Bool) {

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    
    
    // MARK: private function
    
    @objc private func editProfile() {
        self.photoButton.enabled = true
        self.nameTF.enabled = true
        self.genderSegmented.enabled = true
        self.ageTF.hidden = true
        self.ageDatePicker.hidden = false

        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy"
        let currentYear = dateFormatter.stringFromDate(NSDate())
        
        dateFormatter.dateFormat = "MM dd yyyy"
        self.ageDatePicker.date = dateFormatter.dateFromString("01 01 \(Int(currentYear)! - self.student!.age)")!
        
        self.photoButton.enabled = true
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(ProfileController.updatedInfo))
    }
    
    @objc private func updatedInfo() {
        let studentEdited = checkValidate()
        if studentEdited.success {
            if let delegate = self.delegate {
                delegate.updateStudentInfo(studentEdited.student, atIndex: self.index)
                self.navigationController?.popViewControllerAnimated(true)
            }
        }
    }
    
    private func checkValidate() -> (success: Bool, student: Student!) {
        var name = ""
        print("\(self.nameTF.text?.characters.count)")
        if self.nameTF.text != "" {
            name = self.nameTF.text!
            
        } else {
            return (success: false, student: nil)
        }
        
        
        let gender = self.genderSegmented.selectedSegmentIndex == 0 ? "Female" : "Male"
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy"
        let selectedYear = dateFormatter.stringFromDate(self.ageDatePicker.date)
        let age: Int = Int(dateFormatter.stringFromDate(NSDate()))! - Int(selectedYear)!
        
        if age < 0 {
            return (success: false, student: nil)
        }
        
        self.student!.name = name
        self.student!.gender = gender
        self.student!.age = age
        
        return (true, self.student)
    }
    
    private func showCamera() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) {
            
            let imagePickerViewController = getImagePickerViewController(UIImagePickerControllerSourceType.Camera)
            self.presentViewController(imagePickerViewController, animated: true, completion: nil)
            
        } else {
            let errorMessage = UIAlertController(title: "Warning", message: "The Camera doesn't support on this device", preferredStyle: .Alert)
            errorMessage.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler: nil))
            self.presentViewController(errorMessage, animated: true, completion: nil)
        }
    }
    
    private func showPhotoFromLibrary() {
        let imagePickerViewController = getImagePickerViewController(UIImagePickerControllerSourceType.PhotoLibrary)
        self.presentViewController(imagePickerViewController, animated: true, completion: nil)
    }
    
    private func getImagePickerViewController(sourceType: UIImagePickerControllerSourceType) -> UIImagePickerController {
        let imagePickerViewController = UIImagePickerController()
        imagePickerViewController.delegate = self
        imagePickerViewController.allowsEditing = true
        imagePickerViewController.sourceType = sourceType
        
        return imagePickerViewController
    }
    
    //MARK: public function
    func loadData(isDetail: Bool, student: Student, index: Int) {
        self.isDetail = isDetail
        self.student = student
        self.index = index
    }
    
    // NARK: imagePickerViewController Delegate
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let choosenImage = info[UIImagePickerControllerEditedImage] as! UIImage

        self.photoButton.setBackgroundImage(choosenImage, forState: .Normal)
        self.student!.photo = choosenImage
        
        picker.dismissViewControllerAnimated(true, completion: nil)
        
    }
}
