//
//  RootController.swift
//  Bai 3
//
//  Created by Quang Phu on 6/27/16.
//  Copyright © 2016 Quang Phu. All rights reserved.
//

import UIKit

class RootController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let screen = UIScreen.mainScreen().bounds
        
        let widthAvatar: CGFloat = screen.size.width / 4
        let heightAvatar: CGFloat = 100
        
        let count = 15
        
        var row = 0
        var col = 0
        
        for index in 0..<count {
            var frame = CGRectMake(CGFloat(col) * widthAvatar, CGFloat(row) * heightAvatar, widthAvatar, heightAvatar)
            if frame.origin.x >= screen.size.width {
                row += 1
                col = 0
                frame = CGRectMake(CGFloat(col) * widthAvatar, CGFloat(row) * heightAvatar, widthAvatar, heightAvatar)
            }
            let myView = AvatarView(frame: frame)
            myView.lbName.text = "Guest \(index)"
            myView.index = index
            myView.delegate = self
            self.view.addSubview(myView)
            col += 1
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
}

extension RootController: AvatarViewDelegate {
    func didSelectAvatar(myView: AvatarView) {
        print("Seleted view tag : \(myView.index) with name: \(myView.lbName.text)")
    }
}
