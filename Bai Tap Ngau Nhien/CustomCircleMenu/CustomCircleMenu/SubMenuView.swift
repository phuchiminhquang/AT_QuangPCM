//
//  SubMenuView.swift
//  CustomCircleMenu
//
//  Created by Quang Phu on 7/7/16.
//  Copyright © 2016 Quang Phu. All rights reserved.
//

import UIKit

class SubMenuView: UIView {

    
    // MARK: IBOulet & IBAction
    @IBOutlet weak var nameMenuLabel: UILabel!
    @IBOutlet weak var photoMenu: UIButton!
    
    // MARK: Property
    var index = 0
    var photo = ""
    var name = "No Name"
    
    // MARK: Init function for uiview
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        
    }
    
    
    // MARK: Private function
    func setData(index: Int, photo: String, name: String) {
        self.index = index
        self.photoMenu.setImage(UIImage(named: photo), forState: UIControlState.Normal)
        self.nameMenuLabel.text = name
        self.photo = photo
        self.name = name
        print("\(self.index) \(self.photo) \(self.name)")
    }
    
    func zoomOut(newLocation: CGPoint) {
        
//        self.transform = CGAffineTransformMakeScale(0.0, 0.0)
        UIView.animateWithDuration(1, delay: 0.0, options: [.CurveLinear], animations: { () -> Void in
            self.transform = CGAffineTransformIdentity
            self.center = newLocation
        }) { (animationCompleted: Bool) -> Void in
            
        }
    }
    
    // MARK: Public function

}
