//
//  RootController.swift
//  Bai 6
//
//  Created by Quang Phu on 6/24/16.
//  Copyright © 2016 Quang Phu. All rights reserved.
//

import UIKit

class RootController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let screenFrame = self.view.frame
        let sliderWidth: CGFloat = 60
        let sliderHeigth: CGFloat = 100
        
        let sliderFrame = CGRectMake(screenFrame.width / 2 - sliderWidth / 2, screenFrame.height / 2 - sliderWidth / 2, sliderWidth, sliderHeigth)
        
        let myslider = NSBundle.mainBundle().loadNibNamed("CustomSlider", owner: nil, options: nil).last as! CustomSlider
        myslider.frame = sliderFrame

  
        self.view.addSubview(myslider)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    
   
}
