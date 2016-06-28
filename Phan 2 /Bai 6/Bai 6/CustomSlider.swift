//
//  CustomSlider.swift
//  Bai 6
//
//  Created by Quang Phu on 6/24/16.
//  Copyright © 2016 Quang Phu. All rights reserved.
//

import UIKit

protocol CustomSliderDelegate {
    func updateSliderValue(percent: Int)
}


class CustomSlider: UIView {
    
    var lastLocation = CGPoint()
    var borderColor = UIColor(red: 168/255, green: 168/255, blue: 168/255, alpha: 1)
    var delegate: CustomSliderDelegate!
    
    
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
        
        self.centerView.layer.borderColor = borderColor.CGColor
        self.centerView.layer.borderWidth = 1
        
//        self.centerView.layer.shadowColor = UIColor.grayColor().CGColor
//        self.centerView.layer.shadowRadius = 1
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch: UITouch = touches.first! as UITouch {
            if touch.view == centerView || touch.view == upView || touch.view == downView {
              
                let newLocation = touch.locationInView(self)
                let changeValue = self.frame.height - newLocation.y - self.centerView.frame.width / 2

                UIView.animateWithDuration(0.5, delay: 0, options: UIViewAnimationOptions.TransitionNone, animations: { () -> Void in
                    
                    self.heightConstraint.constant = changeValue
//                    self.centerView.frame.origin.y = newLocation.y + self.centerView.frame.width / 2
//                    self.centerView.center = newLocation
                    
                    }, completion: { (finished: Bool) -> Void in
                    self.heightConstraint.constant = changeValue
                        
                    let greenHigth = self.frame.height - self.centerView.center.y - self.centerView.frame.width / 2
                    let sliderHight = self.frame.height - self.centerView.frame.width
                    let percent = Int(greenHigth / sliderHight * 100)
                    self.lbSliderValue.text = "\(percent)%"
                        if let delegate = self.delegate {
                            delegate.updateSliderValue(percent)
                        }
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
                
                let beginPoint = self.centerView.frame.height / 2
                let endPoint = self.frame.height - self.centerView.frame.height / 2
                
                if self.centerView.center.y >= beginPoint && self.centerView.center.y <= endPoint {

                        let changeValue = newLocation.y - lastLocation.y
                        //5
                        let greenHigth = self.frame.height - self.centerView.center.y - self.centerView.frame.width / 2
                        let sliderHight = self.frame.height - self.centerView.frame.width
                        let percent = Int(greenHigth / sliderHight * 100)
                        
                        UIView.animateWithDuration(1, animations: { () -> Void in
                            self.heightConstraint.constant -= changeValue
                            self.lbSliderValue.text = "\(percent)%"
                            
                            if let delegate = self.delegate {
                                delegate.updateSliderValue(percent)
                            }

                        })
                    
                        lastLocation = newLocation
                        print("location: \(lastLocation)")
                }
            }
        }
    }
    
    // MARK: private function
    func updateSlider(percent: Int) {
        let sliderHight: Float = Float(self.frame.height - self.centerView.frame.width)
        let greenHight: Float = Float(percent) * sliderHight / 100
        
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            self.heightConstraint.constant = CGFloat(greenHight)
            self.lbSliderValue.text = "\(percent)%"
        })
    }
    
}







