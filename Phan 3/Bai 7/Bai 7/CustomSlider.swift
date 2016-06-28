//
//  CustomSlider.swift
//  Bai 7
//
//  Created by Quang Phu on 6/28/16.
//  Copyright © 2016 Quang Phu. All rights reserved.
//

import UIKit

protocol CustomSliderDelegate {
    func updateSliderValue(percent: Int)
}


class CustomSlider: UIView {

    // MARK: IBOulet & IBAction
    
    @IBOutlet weak var silverView: UIView!
    @IBOutlet weak var greenView: UIView!
    @IBOutlet weak var rollerLabel: UILabel!
    @IBOutlet weak var rollerView: UIView!
    
    // MARK: Property
    var lastLocation = CGPoint(x: 0,y: 0)
    var delegate: CustomSliderDelegate!
    var isChange = false
    
    // MARK: Init function for uiview
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        self.rollerView.layer.cornerRadius = self.rollerView.frame.size.width / 2
        self.rollerView.clipsToBounds = true
        self.rollerView.layer.borderColor = UIColor(red: 168/255, green: 168/255, blue: 168/255, alpha: 1).CGColor
        self.rollerView.layer.borderWidth = 1
    }
    
    // MARK: Touch funtion
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch: UITouch = touches.first! as UITouch {
            if touch.view == self.greenView || touch.view == self.silverView || touch.view == self.rollerView {
                lastLocation = touch.locationInView(self)
                isChange = true
                print("tap begin")
            }
        }
        
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if isChange {
        if let touch: UITouch = touches.first! as UITouch {
            if touch.view == self.greenView || touch.view == self.silverView || touch.view == self.rollerView {
                var newLocation = touch.locationInView(self)
                newLocation = getNewPoint(newLocation, lengthSlider: self.silverView.frame.height, rollerWidth: self.rollerView.frame.width)
                
                UIView.animateWithDuration(0.5, delay: 0, options: UIViewAnimationOptions.TransitionNone, animations: { () -> Void in
                    self.rollerView.center.y = newLocation.y
                    self.greenView.frame = CGRectMake(self.greenView.frame.origin.x, self.rollerView.center.y, self.greenView.frame.size.width, self.frame.size.height - self.rollerView.center.y)
                    
                    }, completion: { (finished: Bool) -> Void in
                        self.rollerView.center.y = newLocation.y
                        self.greenView.frame = CGRectMake(self.greenView.frame.origin.x, self.rollerView.center.y, self.greenView.frame.size.width, self.frame.size.height - self.rollerView.center.y)
                        
                })
                let sliderHight = self.frame.height - self.rollerView.frame.width
                let greenHigth = self.frame.height - self.rollerView.center.y - self.rollerView.frame.width / 2
                let percent = Int(greenHigth / sliderHight * 100)
                self.rollerLabel.text = "\(percent)%"
                
                if let delegate = self.delegate {
                    delegate.updateSliderValue(percent)
                }
                
                
                lastLocation = self.rollerView.center
                print("tap End")

            }
        }
        }
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch: UITouch = touches.first! as UITouch {
            if touch.view == self.rollerView {
                let newLocation = touch.locationInView(self)
                
                let beginPoint = self.rollerView.frame.height / 2
                let endPoint = self.frame.height - self.rollerView.frame.height / 2
                
                if self.rollerView.center.y > beginPoint && self.rollerView.center.y < endPoint {

                    //5
                    let sliderHight = endPoint - beginPoint
                    let greenHigth = self.frame.height - self.rollerView.center.y - self.rollerView.frame.width / 2
                    let percent = Int(greenHigth / sliderHight * 100)
                    
                    
                    self.rollerView.center.y = newLocation.y
                    self.greenView.frame.origin.y = self.rollerView.center.y
                    self.greenView.frame.size.height = self.frame.height - self.rollerView.center.y

                    
                    self.rollerLabel.text = "\(percent)%"
                    
                    if let delegate = self.delegate {
                        delegate.updateSliderValue(percent)
                    }
                    
                    lastLocation = newLocation
                    print("location: \(lastLocation)")
                    
                    print("tap move")
                }
//                else if self.rollerView.center.y <= beginPoint {
//                    self.rollerView.center.y = beginPoint + 1
//                } else if self.rollerView.center.y >= endPoint {
//                    self.rollerView.center.y = endPoint - 1
//                }
            }
            isChange = false
        }
    }
    
    // MARK: Private function
    func getNewPoint(point: CGPoint, lengthSlider: CGFloat, rollerWidth: CGFloat ) -> CGPoint {
        let percent = Int((lengthSlider - point.y) / lengthSlider * 100)
        print("percent: \(percent)")
        let begin = rollerWidth / 2
        let end = lengthSlider - rollerWidth / 2
        return CGPoint(x: point.x, y: lengthSlider - rollerWidth / 2 - (CGFloat(percent) * (end - begin) / 100))
        
    }
    
    func updateSlider(percent: Int) {
        let rollerWidth = self.rollerView.frame.size.width
        let lengthSlider = self.frame.size.height
        
        let begin = rollerWidth / 2
        let end = lengthSlider - rollerWidth / 2
        
        let newLocation = CGPoint(x: self.rollerView.center.x, y: self.frame.height - rollerWidth / 2 - (CGFloat(percent) * (end - begin) / 100))
        
        UIView.animateWithDuration(1, delay: 0, options: UIViewAnimationOptions.TransitionNone, animations: { () -> Void in
            self.rollerView.center.y = newLocation.y
            self.greenView.frame = CGRectMake(self.greenView.frame.origin.x, self.rollerView.center.y, self.greenView.frame.size.width, self.frame.size.height - self.rollerView.center.y)
            
            }, completion: { (finished: Bool) -> Void in
                self.rollerView.center.y = newLocation.y
                self.greenView.frame = CGRectMake(self.greenView.frame.origin.x, self.rollerView.center.y, self.greenView.frame.size.width, self.frame.size.height - self.rollerView.center.y)
                
        })
        self.rollerLabel.text = "\(percent)%"
        
    }
 
    // MARK: Public function
    
    
}
