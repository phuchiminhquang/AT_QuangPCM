//
//  RootController.swift
//  Bai 6
//
//  Created by Quang Phu on 6/24/16.
//  Copyright © 2016 Quang Phu. All rights reserved.
//

import UIKit

class RootController: UIViewController {

   
    
    @IBOutlet weak var tfSliderValue: UITextField!
    var isLoad = false
    var myslider = CustomSlider()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
        if !isLoad {
            let screenFrame = self.view.frame
            let sliderWidth: CGFloat = 60
            let sliderHeigth: CGFloat = 200
            
            let sliderFrame = CGRectMake(screenFrame.width / 2 - sliderWidth / 2, screenFrame.height / 2 - sliderWidth / 2, sliderWidth, sliderHeigth)
            
            myslider = NSBundle.mainBundle().loadNibNamed("CustomSlider", owner: nil, options: nil).last as! CustomSlider
            myslider.frame = sliderFrame
            myslider.delegate = self
            self.view.addSubview(myslider)
            isLoad = true
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    
    @IBAction func udpateSlider(sender: AnyObject) {
        if let number = Int(self.tfSliderValue.text!) {
            if number >= 0 && number <= 100 {
                self.myslider.updateSlider(number)
            }
        }
    }
   
}

extension RootController: CustomSliderDelegate {
    func updateSliderValue(percent: Int) {
        self.tfSliderValue.text = "\(percent)"
    }
}
