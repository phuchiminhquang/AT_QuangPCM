//
//  CustomSegmented.swift
//  CustomSegmented
//
//  Created by Quang Phu on 6/24/16.
//  Copyright © 2016 Quang Phu. All rights reserved.
//

import UIKit

protocol CustomSegmentedDelegate {
    func didChangeView(myView: CustomSegmented, index: Int)
}


class CustomSegmented: UIView {

    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    @IBOutlet weak var viewB: UIView!
    @IBOutlet weak var viewA: UIView!
    @IBOutlet weak var viewC: UIView!
    
    var delegate: CustomSegmentedDelegate!
    let green = UIColor(red: 66/255, green: 213/255, blue: 80/255, alpha: 1)
    
    var selectedSegment = UIView()
    
    @IBAction func changeView(sender: AnyObject) {

        if let delegate = self.delegate {
            let index = sender.tag
            setColor(index)
            delegate.didChangeView(self, index: index)
        }
        
    }
    
    func setColor(index: Int) {
        
        selectedSegment.backgroundColor = UIColor.whiteColor()
        
        switch index {
        case 0:
            selectedSegment = self.viewA
            self.viewA.backgroundColor = green
        case 1:
            selectedSegment = self.viewB
            self.viewB.backgroundColor = green
        default:
            selectedSegment = self.viewC
            self.viewC.backgroundColor = green
        }
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
         selectedSegment = viewA
        setBorder(viewA)

    }
    
    func setBorder(view: UIView) {
        view.layer.borderWidth = 1.0
        view.layer.cornerRadius = 10.0
        view.layer.masksToBounds = true
        view.layer.borderColor = UIColor.brownColor().CGColor
        view.clipsToBounds = true
    }
    
    

}
