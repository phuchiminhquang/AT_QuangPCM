//
//  RootController.swift
//  Bai 1
//
//  Created by Quang Phu on 7/6/16.
//  Copyright © 2016 Quang Phu. All rights reserved.
//

import UIKit

class RootController: UIViewController {

    // MARK: Property
    
    
    // MARK: Init View
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let frame = CGRectMake(100, 100, 100, 100)
        let ballview = BallView(frame: frame)
        self.view.addSubview(ballview)
        
    }
    
    override func viewWillAppear(animated: Bool) {
        
    }
    
    override func viewDidAppear(animated: Bool) {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    // MARK: private function
}
