//
//  BallView.swift
//  Bai 1
//
//  Created by Quang Phu on 7/6/16.
//  Copyright © 2016 Quang Phu. All rights reserved.
//

import UIKit

@IBDesignable
class BallView: UIView {

    // MARK: IBOulet & IBAction
    
    
    // MARK: Property
//    let ballColor = UIColor.blueColor()
    @IBInspectable var ballColor: UIColor = UIColor.greenColor() {
        didSet {
            setNeedsDisplay()
        }
    }
    
    // MARK: Init function for uiview
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.redColor()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func drawRect(rect: CGRect) {
        // Solution One
        let path = UIBezierPath(ovalInRect: rect)
        ballColor.setFill()
        path.fill()

        
        // Solution two
//        let context = UIGraphicsGetCurrentContext()
//        
//        CGContextSetFillColorWithColor(context, self.ballColor.CGColor)
//        CGContextFillEllipseInRect(context, self.bounds)
        
    
    }
    
    
    // MARK: Private function
    
    
    // MARK: Public function

}
