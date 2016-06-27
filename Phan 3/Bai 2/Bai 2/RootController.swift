//
//  RootController.swift
//  Bai 2
//
//  Created by Quang Phu on 6/27/16.
//  Copyright © 2016 Quang Phu. All rights reserved.
//

import UIKit

class RootController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let frame = CGRectMake(20, 100, 80, 120)
        
        let avatar = AvatarView(frame: frame)
        avatar.lbName.text = "Quang Phu"
        avatar.delegate = self
        avatar.tag = 99
        self.view.addSubview(avatar)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
      
    }
    
}

extension RootController: AvatarViewDelegate {
    func didSelectAvatar(myView: AvatarView) {
        print("Seleted view tag : \(myView.tag) with name: \(myView.lbName.text)")
    }
}
