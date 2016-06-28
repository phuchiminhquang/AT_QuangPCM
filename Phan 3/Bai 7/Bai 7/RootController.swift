//
//  RootController.swift
//  Bai 7
//
//  Created by Quang Phu on 6/28/16.
//  Copyright © 2016 Quang Phu. All rights reserved.
//

import UIKit

class RootController: UIViewController {
    
    // MARK: IBOutlet & IBAction
    @IBOutlet weak var valueSliderTF: UITextField!
    @IBAction func updateSlider(sender: AnyObject) {
        if let percent = self.valueSliderTF.text {
            if Int(percent) >= 0 && Int(percent) <= 100 {
                self.mySlider.updateSlider(Int(percent)!)
            }
        }
    }
   
    
    // MARK: Property
    var mySlider: CustomSlider!
    
    // MARK: Init View
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func viewWillAppear(animated: Bool) {
        loadSliderUI()
    }
    
    override func viewDidAppear(animated: Bool) {
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    
    // MARK: private function
    func loadSliderUI(){
        
        let screen = UIScreen.mainScreen().bounds
        
        mySlider = NSBundle.mainBundle().loadNibNamed("CustomSlider", owner: self, options: nil).last as! CustomSlider
        mySlider.frame = CGRectMake(screen.size.width / 2 - 20, screen.size.height / 2 - 100, 50, 200)
        mySlider.delegate = self
//        mySlider.backgroundColor = UIColor.redColor()
        self.view.addSubview(mySlider)
    }
    
}


extension RootController: CustomSliderDelegate {
    func updateSliderValue(percent: Int) {
        self.valueSliderTF.text = "\(percent)"
    }
}
