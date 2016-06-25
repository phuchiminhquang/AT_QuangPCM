//
//  CustomSlider.swift
//  Bai 6
//
//  Created by Quang Phu on 6/24/16.
//  Copyright © 2016 Quang Phu. All rights reserved.
//

import UIKit

class CustomSlider: UIView {
    
    var lastLocation = CGPoint()
    
    // MARK: IBOutlet
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var upView: UIView!
    @IBOutlet weak var centerView: UIView!
    @IBOutlet weak var downView: UIView!
    
    
    @IBOutlet weak var lbSliderValue: UILabel!
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    
    override func awakeFromNib() {
        self.centerView.layer.cornerRadius = self.centerView.frame.width / 2
        self.centerView.clipsToBounds = true
        
//        self.centerView.layer.borderColor = UIColor.grayColor().CGColor
//        self.centerView.layer.borderWidth = 1
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch: UITouch = touches.first! as UITouch {
            if touch.view == centerView {
                lastLocation = touch.locationInView(self)
            } else if touch.view == upView || touch.view == downView {
                let newLocation = touch.locationInView(self)
                let changeValue = self.frame.height - newLocation.y

                UIView.animateWithDuration(1, delay: 0.5, options: UIViewAnimationOptions.TransitionNone, animations: { () -> Void in
                    self.heightConstraint.constant = changeValue
                    }, completion: { (finished: Bool) -> Void in
                     self.heightConstraint.constant = changeValue
                })
                
                lastLocation = touch.locationInView(self)
            } else {
                lastLocation = touch.locationInView(self)
            }
            print(lastLocation)
        }
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch: UITouch = touches.first! as UITouch {
            if touch.view == centerView {
                let newLocation = touch.locationInView(self)
//        newLocation.y >= self.centerView.frame.width / 2 && newLocation.y <= CGRectGetHeight(self.frame) - self.centerView.frame.width / 2
                
                if self.centerView.frame.origin.y >= 0 && self.centerView.frame.origin.y + self.centerView.frame.width <= self.frame.height {
                    
                    if newLocation.y >= self.centerView.frame.width / 2 && newLocation.y <= CGRectGetHeight(self.frame) - self.centerView.frame.width / 2 {
                        
                        let changeValue = newLocation.y - lastLocation.y
                        //5
                        let greenHigth = self.frame.height - newLocation.y - self.centerView.frame.width / 2
                        let sliderHight = self.frame.height - self.centerView.frame.width
                        
                        
                        UIView.animateWithDuration(1, animations: { () -> Void in
                            self.heightConstraint.constant -= changeValue
                            self.lbSliderValue.text = "\(Int(greenHigth / sliderHight * 100))%"
                        })
                        lastLocation = newLocation
                        print("location: \(lastLocation)")
                    }
                }
            }
        }
    }
    
}







