//
//  RootController.swift
//  Bai 5
//
//  Created by Quang Phu on 6/24/16.
//  Copyright © 2016 Quang Phu. All rights reserved.
//

import UIKit

class RootController: UIViewController {

    
    // MARK: IBOutlet
    
    @IBOutlet weak var moveView: UIView!
    
    var lastLocation = CGPoint(x: 0, y: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch = touches.first {
            self.lastLocation = touch.locationInView(self.view)
        }

    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.locationInView(self.view)
            let moveViewFrame = self.moveView.frame
            let screen = self.view.frame
            
            if moveViewFrame.origin.x >= 0 && moveViewFrame.origin.y >= 0 && moveViewFrame.origin.x + moveViewFrame.width < screen.width && moveViewFrame.origin.y + moveViewFrame.height < screen.height {
                self.moveView.center = location
            }
//            else {
//                self.moveView.center =
//            }
            
            
        }
        

    }
    
}
