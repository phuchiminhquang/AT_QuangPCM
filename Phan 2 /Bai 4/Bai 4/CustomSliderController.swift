//
//  CustomSliderController.swift
//  Bai 4
//
//  Created by Quang Phu on 6/24/16.
//  Copyright © 2016 Quang Phu. All rights reserved.
//

import UIKit

class CustomSliderController: UIViewController {

    @IBOutlet weak var constant: NSLayoutConstraint!
    
    
    
    @IBOutlet weak var superView: UIView!
    @IBOutlet weak var sliderView: UIView!

    
    var lastLocation = CGPoint()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch = touches.first {
            self.lastLocation = touch.locationInView(self.view)
        }
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.locationInView(self.view)
            
//            self.sliderView.center = CGPoint(x: self.sliderView.center.x, y: (location.y - self.lastLocation.y) + self.sliderView.center.y)
//            lastLocation = touch.locationInView(self.view)
             self.constant.constant = self.superView.frame.height - (location.y + self.sliderView.frame.height / 2)
//            if location.y > self.sliderView.frame.maxY {
////
//                self.constant.constant -= 5
//            } else {
//                self.constant.constant += 5
//            }
            
            
        }
    }
   
}
