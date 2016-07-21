//
//  AnnotationPhoto.swift
//  AT_QuangPCM_Restaurants
//
//  Created by Asiantech1 on 7/20/16.
//  Copyright © 2016 Quang Phu. All rights reserved.
//

import UIKit


let thumbnailSize = CGSize(width: 60,height: 60)

class AnnotationPhoto: UIView {

    private var photoName = ""
    

    
    convenience init(frame: CGRect, photoName: String) {
        self.init(frame: frame,photoName: photoName)
        self.photoName = photoName
        self.configView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    
    }
    
    func configView() {
        
        let thumbnail = UIImageView(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: thumbnailSize))
        thumbnail.image = UIImage(named: "bg_pin")
        thumbnail.contentMode = .ScaleToFill
        self.addSubview(thumbnail)

        
    }
    
}
