//
//  DetailController.swift
//  Bai 4
//
//  Created by Quang Phu on 7/6/16.
//  Copyright © 2016 Quang Phu. All rights reserved.
//

import UIKit

class DetailController: UIViewController {

    // MARK: IBOutlet & IBAction
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var ageTF: UITextField!
    @IBOutlet weak var genderSegmented: UISegmentedControl!
    
    
    // MARK: Property
    var name = "No Name"
    var age = 0
    var gender = "Female"
    var photo = "torres.jpg"
    
    // MARK: Init View
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Detail"
        
        self.photoImageView.image = UIImage(named: self.photo)
        self.nameTF.text = self.name
        self.ageTF.text = "\(self.age)"
        self.genderSegmented.selectedSegmentIndex = self.gender == "Female" ? 0 : 1
        
        
        
        
    }
    
    override func viewWillAppear(animated: Bool) {
        
    }
    
    override func viewDidAppear(animated: Bool) {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
    
    // MARK: private function
    func loadData(photo: String, name: String, age: Int, gender: String) {
        self.photo = photo
        self.name = name
        self.age = age
        self.gender = gender
    }
    
    
}
