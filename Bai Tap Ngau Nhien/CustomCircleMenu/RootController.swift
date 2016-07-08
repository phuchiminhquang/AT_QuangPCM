//
//  RootController.swift
//  CustomCircleMenu
//
//  Created by Quang Phu on 7/7/16.
//  Copyright © 2016 Quang Phu. All rights reserved.
//

import UIKit

class RootController: UIViewController {

    // MARK: IBOutlet & IBAction
    @IBAction func showMenu(sender: AnyObject) {
        let itemPoints = circleMenu(self.cancelView!.center, numberItems: self.numberItem, r: 100)
        
        for point in itemPoints {
            let frame = CGRectMake(point.x - 25, point.y - 25, 50, 50)
            newPositions.append(frame)
            let submenuview = UIView(frame: frame)
            submenuview.backgroundColor = UIColor.greenColor()
            submenuview.layer.cornerRadius = 25
            self.view.addSubview(submenuview)
        }
        
    }
    @IBAction func zoomIn(sender: AnyObject) {
        self.cancelView!.transform = CGAffineTransformMakeScale(1, 1)
        
        UIView.animateWithDuration(1, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 5,
                                   options: UIViewAnimationOptions.CurveLinear,
                                   animations: { () -> Void in
                                    self.cancelView!.transform = CGAffineTransformMakeScale(0.1, 0.1)
            },
                                   completion: nil)
    }
    
    @IBAction func zoomOut(sender: AnyObject) {
        self.cancelView!.transform = CGAffineTransformMakeScale(0.1, 0.1)
        
//        UIView.animateWithDuration(1, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 5,
//                                   options: UIViewAnimationOptions.CurveLinear,
//                                   animations: { () -> Void in
//                                    self.cancelView!.transform = CGAffineTransformMakeScale(1, 1)
//                                    self.cancelView!.frame = CGRectMake( 100, 100, 50, 50)
//            },
//                                   completion: nil)
        
        self.cancelView!.transform = CGAffineTransformMakeScale(0.0, 0.0)
        UIView.animateWithDuration(1, delay: 0.0, options: [.CurveLinear], animations: { () -> Void in
                    self.cancelView!.transform = CGAffineTransformIdentity
                    self.cancelView!.frame = CGRectMake( 100,100, 50, 50)
                }) { (animationCompleted: Bool) -> Void in
                    
                }
    }

    
    // MARK: Property
    var newPositions: [CGRect] = []
    let numberItem = 4
    var cancelView: UIView? = nil
    
    // MARK: Init View
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    
    override func viewWillAppear(animated: Bool) {
        
    }
    
    override func viewDidAppear(animated: Bool) {
//        UIView.animateWithDuration(1, delay: 0.2, options: UIViewAnimationOptions.CurveEaseOut, animations: {
//            //            cancelView.frame.size = CGSize(width: 50, height: 50)
//            
//            //            cancelView.frame = CGRectMake( CGRectGetWidth(screen) / 2 - 25, CGRectGetHeight(screen) / 2 - 25, 50, 50)
//                        self.cancelView!.alpha = 1
////            self.cancelView!.transform = CGAffineTransformMakeScale(1, 1)
//            }, completion: { finished in
//                //                self.cancelView!.transform = CGAffineTransformIdentity
//                //                self.cancelView!.alpha = 1
//                //                print("Basket doors opened!")
//        })
        self.cancelView!.transform = CGAffineTransformMakeScale(0.0, 0.0)
        
        UIView.animateWithDuration(1, delay: 0.0, options: [.CurveLinear], animations: { () -> Void in
            self.cancelView!.transform = CGAffineTransformIdentity
            self.cancelView!.frame = CGRectMake( 100,100, 50, 50)
        }) { (animationCompleted: Bool) -> Void in
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
    
    // MARK: private function
    func circleMenu(center: CGPoint, numberItems: Int, r: Double) -> [CGPoint] {
        let ox = Double(center.x)
        let oy = Double(center.y)
        
        let itemCorner = 360 / Double(numberItems)
        print("itemCorner = \(itemCorner)")
        var itemPoints: [CGPoint] = []
        
        for i in 0..<numberItems {
            let nextCorner = Double(i) * itemCorner
            print("itemCorner = \(nextCorner)")
            print("sin: \(sin(nextCorner * M_PI / 180))  cos: \(cos(nextCorner * M_PI / 180))")
            
            let x = r * sin(nextCorner * M_PI / 180)
            let y = r * cos(nextCorner * M_PI / 180)
            
            itemPoints.append(CGPoint(x: ox + x, y: oy - y))
        }
        return itemPoints
    }
    
    
}
