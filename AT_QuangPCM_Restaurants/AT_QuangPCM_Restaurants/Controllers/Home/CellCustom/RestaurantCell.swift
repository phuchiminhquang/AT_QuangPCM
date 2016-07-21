//
//  RestaurantCell.swift
//  AT-QuangPCM
//
//  Created by Quang Phu on 7/13/16.
//  Copyright © 2016 demo. All rights reserved.
//

import UIKit

class RestaurantCell: UITableViewCell {

    // MARK: IBOutlet
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var name: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configurationUI()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)


    }
    
    // MARK: private function
    func configurationUI() {
        self.photo.border(5)
        self.name.adjustsFontSizeToFitWidth = true
    }
    
}
