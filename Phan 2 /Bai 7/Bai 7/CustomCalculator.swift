//
//  CustomCalculator.swift
//  Bai 7
//
//  Created by Quang Phu on 6/25/16.
//  Copyright © 2016 Quang Phu. All rights reserved.
//

import UIKit

protocol CustomCalculatorDelegate {
    func resetResult()
    func sendCharacterWith(tag: Int)

}

class CustomCalculator: UIView {
    
   
    // MARK: property
    var delegate: CustomCalculatorDelegate!
    
    // MARK: IBOutlet
    
    // MARK: IBAciton
    override init(frame: CGRect) {
        super.init(frame: frame)
       
    }
    
    
    @IBAction func pressNumber(sender: AnyObject) {
        print(sender.tag)
        if let delegate = self.delegate {
            delegate.sendCharacterWith(sender.tag)
            
        }
    }
    
    @IBAction func pressOperation(sender: AnyObject) {
        if let delegate = self.delegate {
            delegate.sendCharacterWith(sender.tag)
        }
    }
    
    @IBAction func calculate(sender: AnyObject) {
        if let delegate = self.delegate {
            delegate.sendCharacterWith(sender.tag)
        }
    }
    
    @IBAction func resetResult(sender: AnyObject) {
        if let delegate = self.delegate {
            delegate.resetResult()
        }
    }

    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        
    }

}
