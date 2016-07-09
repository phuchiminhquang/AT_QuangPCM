//
//  ContactCell.swift
//  Bai 7
//
//  Created by Quang Phu on 7/9/16.
//  Copyright © 2016 Quang Phu. All rights reserved.
//

import UIKit

class ContactCell: UITableViewCell {

    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.emailLabel.adjustsFontSizeToFitWidth = true
        self.phoneLabel.adjustsFontSizeToFitWidth = true
        self.photoImageView.layer.cornerRadius = self.photoImageView.frame.size.width / 2
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configWithContactEntry(contact: ContactEntry) {
        self.photoImageView.image = contact.image ?? UIImage(named: "default")
        self.nameLabel.text = contact.name
        self.emailLabel.text = contact.email ?? ""
        self.phoneLabel.text = contact.phone ?? ""
    
    }
    
}
