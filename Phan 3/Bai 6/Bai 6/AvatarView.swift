//
//  AvatarView.swift
//  Bai 6
//
//  Created by Quang Phu on 6/28/16.
//  Copyright © 2016 Quang Phu. All rights reserved.
//

import UIKit

protocol AvatarViewDelegate {
    func showInfo(myView: AvatarView)
}

class AvatarView: UIView {

    // MARK: IBOutlet & IBAction
    @IBOutlet weak var avatarImageView: UIImageView!
   
    @IBOutlet weak var nameLabel: UILabel!

    @IBAction func tapButton(sender: AnyObject) {
        if let delegate = self.delegate {
            delegate.showInfo(self)
        }
    }
    
    // MARK: property
    var delegate: AvatarViewDelegate!
    var index = 0
    
    // MARK: Init view
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    // MARK: private function
    func loadDataForComponent(image: String, name: String, index: Int) {
        self.avatarImageView.image = UIImage(named: image)
        self.nameLabel.text = name
        self.index = index
    }
    
}
