//
//  CustomSlider.swift
//  Bai 6
//
//  Created by Quang Phu on 6/24/16.
//  Copyright © 2016 Quang Phu. All rights reserved.
//

import UIKit

class CustomSlider: UIView {

    
    // MARK: IBOutlet
    
    @IBOutlet weak var upView: UIView!
    @IBOutlet weak var centerView: UIView!
    @IBOutlet weak var downView: UIView!
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.centerView.layer.cornerRadius = self.centerView.frame.width / 2
        self.centerView.clipsToBounds = true
        
        self.centerView.layer.borderColor = UIColor.brownColor().CGColor
        self.centerView.layer.borderWidth = 1
        

    }
    
    
    
    
}
