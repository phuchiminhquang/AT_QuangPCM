//
//  RatingControl.swift
//  AT_QuangPCM_Restaurants
//
//  Created by Quang Phu on 7/14/16.
//  Copyright © 2016 Quang Phu. All rights reserved.
//

import UIKit

private extension Selector {
    static let didTapRatingButton = #selector(RatingControl.didTapRatingButton(_:))
}

class RatingControl: UIView {
    
    private var ratingButtons = [UIButton]()

    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        for i in 0..<5 {
            let button = UIButton(frame: CGRect(x: 0, y: 0, width: ButtonSize.ratingButton.width, height: ButtonSize.ratingButton.height))
            button.tag = i
            button.addTarget(self, action: .didTapRatingButton, forControlEvents: .TouchUpInside)

            button.setBackgroundImage(UIImage(named: "ic_rating"), forState: .Normal)
            self.ratingButtons.append(button)
            addSubview(button)
        }
    }

    override func intrinsicContentSize() -> CGSize {
        return CGSize(width: (ButtonSize.ratingButton.width + 5) * 5, height: ButtonSize.ratingButton.height)
    }
    
    override func layoutSubviews() {
        var buttonFrame = CGRect(x: 0, y: 0, width: ButtonSize.ratingButton.width, height: ButtonSize.ratingButton.height)
        
        // Offset each button's origin by the length of the button plus spacing.
        for (index, button) in ratingButtons.enumerate() {
            buttonFrame.origin.x = CGFloat(CGFloat(index) * (ButtonSize.ratingButton.width + CGFloat(5)))
            button.frame = buttonFrame
        }
    }
    
    func didTapRatingButton(sender: UIButton) {
        for (index, button) in self.ratingButtons.enumerate() {
            if index <= sender.tag {
                button.setBackgroundImage(UIImage(named: "ic_rating_active"), forState: .Normal)
            } else {
                button.setBackgroundImage(UIImage(named: "ic_rating"), forState: .Normal)
            }
            print("\(sender.tag)")
        }
        
    }
}
