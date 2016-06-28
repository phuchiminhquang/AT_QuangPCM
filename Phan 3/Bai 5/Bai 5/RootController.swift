//
//  RootController.swift
//  Bai 5
//
//  Created by Quang Phu on 6/27/16.
//  Copyright © 2016 Quang Phu. All rights reserved.
//

import UIKit

class RootController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let screen = UIScreen.mainScreen().bounds

        let numberOfRow = 4
        let count = 50
        
        let widthAvatar: CGFloat = screen.size.width / CGFloat(numberOfRow)
        let heightAvatar: CGFloat = 120
        
        let scrollview = UIScrollView(frame: CGRectMake(0, 0, screen.size.width, screen.size.height))
        scrollview.contentSize = CGSize(width: screen.size.width, height: CGFloat(count) / CGFloat(numberOfRow) * CGFloat(heightAvatar))
        self.view.addSubview(scrollview)
        
        
        
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
            scrollview.addSubview(myView)
            col += 1
        }
    }
    
    // MARK: private function
    func showAvatar() {
        
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
