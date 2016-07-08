//
//  CustomTableViewCell.swift
//  Bai 4
//
//  Created by Quang Phu on 7/6/16.
//  Copyright © 2016 Quang Phu. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.photoImageView.layer.cornerRadius = self.photoImageView.frame.size.width / 2
        self.photoImageView.clipsToBounds = true
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
