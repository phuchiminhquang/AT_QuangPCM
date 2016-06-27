//
//  AvatarView.swift
//  Bai 4
//
//  Created by Quang Phu on 6/27/16.
//  Copyright © 2016 Quang Phu. All rights reserved.
//

import UIKit

protocol AvatarViewDelegate {
    func didSelectAvatar(myView: AvatarView, tag: Int)
}


class AvatarView: UIView {

    @IBOutlet weak var avatarImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    var delegate: AvatarViewDelegate!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    @IBAction func tapButton(sender: AnyObject) {
        if let deleagte = self.delegate {
            deleagte.didSelectAvatar(self,tag: self.tag)
        }
    }
}
