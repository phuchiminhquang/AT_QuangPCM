//
//  RootController.swift
//  CustomSegmented
//
//  Created by Quang Phu on 6/24/16.
//  Copyright © 2016 Quang Phu. All rights reserved.
//

import UIKit

class RootController: UIViewController {

    @IBOutlet weak var viewC: UIView!
    @IBOutlet weak var viewB: UIView!
    @IBOutlet weak var viewA: UIView!
    
   // weak var myView: UIView!

    var selectedView = UIView()
    var isloaded = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
//        let mySegmented = NSBundle.mainBundle().loadNibNamed("CustomSegmented", owner: nil, options: nil).last as! CustomSegmented
//        //mySegmented.heightConstraint.constant = 50
//        mySegmented.delegate = self
//        
//        self.view.addSubview(mySegmented)
//        mySegmented.frame = CGRect(x: 0, y: 0, width: 300, height: 20)
    }

    override func viewDidAppear(animated: Bool) {
        if isloaded == false {
            let screenFrame = self.view.frame
            let segmentedWidth: CGFloat = 250
            let segmentedHeigth: CGFloat = 40
            
            let segmentedFrame = CGRectMake(screenFrame.width / 2 - segmentedWidth / 2, screenFrame.height / 2 - segmentedWidth / 2, segmentedWidth, segmentedHeigth)
   
        
            let mySegmented = NSBundle.mainBundle().loadNibNamed("CustomSegmented", owner: nil, options: nil).last as! CustomSegmented
            mySegmented.frame = segmentedFrame
            
            mySegmented.delegate = self
            self.view.addSubview(mySegmented)
            
            isloaded = true
            selectedView = viewA
            self.viewB.hidden = true
            self.viewC.hidden = true
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    
    }
    
    func changeViewWith(index: Int) {
        print(index)
        selectedView.hidden = true
        
        switch index {
        case 0:
            selectedView = self.viewA
            selectedView.hidden = false
            
        case 1:
            selectedView = self.viewB
            selectedView.hidden = false
        case 2:
            selectedView = self.viewC
            selectedView.hidden = false
        default:
            print("default")
        }
    }
    

}

extension RootController: CustomSegmentedDelegate {
    func didChangeView(myView: CustomSegmented, index: Int) {
        changeViewWith(index)
    }
}
