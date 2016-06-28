//
//  RootController.swift
//  Bai 6
//
//  Created by Quang Phu on 6/28/16.
//  Copyright © 2016 Quang Phu. All rights reserved.
//

import UIKit

class RootController: UIViewController {

    
    // MARK: Property
    var count = 50
    var names = ["Quang","Phu","Kim","Minh","Loi","Thi","No","Pheo","Teo","Tan","Tue"]
    
    // MARK: Init View
    override func viewDidLoad() {
        super.viewDidLoad()
        showListOfAvatar(count)
        
    }
    
    override func viewWillAppear(animated: Bool) {
        
    }
    
    override func viewDidAppear(animated: Bool) {
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    
    // MARK: private function
    func showListOfAvatar(count: Int){
        let screen = UIScreen.mainScreen().bounds
        let numberOfRow = 4
       
        let widthAvatar: CGFloat = screen.size.width / CGFloat(numberOfRow)
        let heightAvatar: CGFloat = 120
        
        let scrollview = UIScrollView(frame: CGRectMake(0, 0, screen.size.width, screen.size.height))
        scrollview.contentSize = CGSize(width: screen.size.width, height: CGFloat(count) / CGFloat(numberOfRow) * CGFloat(heightAvatar) + heightAvatar)
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
            
            let myView = NSBundle.mainBundle().loadNibNamed("AvatarView", owner: self, options: nil).last as! AvatarView
            myView.frame = frame
            myView.loadDataForComponent("avatar", name: names[index % names.count], index: index)
            myView.delegate = self
            
            scrollview.addSubview(myView)
            
            col += 1
        }
    }
}

extension RootController: AvatarViewDelegate {
    func showInfo(myView: AvatarView) {
        print("View tag is \(myView.index) with name is \(myView.nameLabel.text)")
    }
}
