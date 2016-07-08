//
//  CircleMenuView.swift
//  Bai-tap-kt
//
//  Created by Nguyen Thanh Su on 7/7/16.
//  Copyright © 2016 Nguyen Thanh Su. All rights reserved.
//

import UIKit

private let size = 60
private let sizeButton = CGSize(width: size, height: size)
private let labelSize = CGSize(width: sizeButton.width, height: 20)

protocol CircleMenuViewDelegate: NSObjectProtocol {
    func titleAtIndex(circleMenu: CircleMenuView, index: Int) -> String!
    func imageNameAtIndex(circleMenu: CircleMenuView, index: Int) -> String!
    func numberOfItem(circleMenu: CircleMenuView) -> Int!
}

class CircleMenuView: UIView {
    weak var delegate: CircleMenuViewDelegate? {
        didSet {
            self.numberOfItem = (delegate?.numberOfItem(self))!
            self.radian = 360 / Double(numberOfItem) * M_PI / 180
            configItems()
        }
    }
    
    weak var centerButton: UIButton!
    private var radius: CGFloat = 0
    private var numberOfItem = 0
    private var radian = 0.0
    private var items: [UIView] = []
    private var location: [CGPoint] = []
    
    convenience init(frame: CGRect, radius: CGFloat) {
        self.init(frame: frame)
        self.radius = radius
        self.configView()
    }
   
    private func configView() {
        self.backgroundColor = UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 0.7)
        let centerButton = UIButton(type: .Custom)
        centerButton.setImage(UIImage(named: "circle_close"), forState: .Normal)
        centerButton.frame.size = sizeButton
        centerButton.center = center
        centerButton.addTarget(self, action: #selector(buttonCancelDidTap(_:)), forControlEvents: .TouchUpInside)
        self.addSubview(centerButton)
        self.centerButton = centerButton
    }
    
    private func configItems() {
        for i in 0..<numberOfItem {
            let subView = UIView()
            subView.bounds.size = CGSize(width: sizeButton.width, height: sizeButton.height + labelSize.height)
            subView.transform = CGAffineTransformMakeScale(0, 0)
            subView.alpha = 0
            subView.center = centerButton.center
            let circleButton = createButton(delegate?.imageNameAtIndex(self, index: i))
            subView.addSubview(circleButton)
            subView.clipsToBounds = true
            let label = UILabel(frame: CGRect(origin: CGPoint(x: 0, y: sizeButton.height), size: labelSize))
            label.textAlignment = .Center
            label.adjustsFontSizeToFitWidth = true
            label.textColor = UIColor.whiteColor()
            label.text = delegate?.titleAtIndex(self, index: i)
            subView.addSubview(label)
            self.addSubview(subView)
            items.append(subView)
            circleButton.tag = i
            circleButton.addTarget(self, action: #selector(didTapAtItem(_:)), forControlEvents: .TouchUpInside)
        }
        self.alpha = 0
        UIView.animateWithDuration(0.6, animations: { () -> Void in
            self.alpha = 1
        }) { (complete) -> Void in
            self.startAnimationForView()
        }
    }
    
    @objc private func didTapAtItem(sender: UIButton) {
        for item in items {
            item.hidden = true
        }
        self.items[sender.tag].hidden = false
        self.centerButton.hidden = true
        self.items[sender.tag].bounds.size = sizeButton
        UIView.animateWithDuration(0.5, animations: {
            self.items[sender.tag].center = self.center
        }) { (complete) -> Void in
            UIView.animateWithDuration(0.5, animations: {
                self.items[sender.tag].transform = CGAffineTransformMakeScale(0.01, 0.01)
            }) { (complete) -> Void in
                self.removeFromSuperview()
            }
        }
    }
    private func startAnimationForView() {
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            for (index, item) in self.items.enumerate() {
                item.center = self.getPointAtRadius(index)
                item.alpha = 1
                item.transform = CGAffineTransformMakeScale(1, 1)
            }
        }) { (complete) -> Void in
            
        }
    }
    
    private func getPointAtRadius(index: Int) -> CGPoint {
        let radian = self.radian * Double(index)
        let dx = self.radius * CGFloat(sin(radian))
        let dy = self.radius * CGFloat(cos(radian))
        let x = self.center.x + dx
        let y = self.center.y - dy
        return CGPoint(x: x, y: y)
    }
    
    
    @objc private func buttonCancelDidTap(sender: UIButton) {
        UIView.animateWithDuration(0.9, animations: {
            for item in self.items {
                item.center = self.center
                item.transform = CGAffineTransformMakeScale(0.01, 0.01)
            }
        }) { (complete) -> Void in
            UIView.animateWithDuration(0.5, delay: 0.3, options: .TransitionNone, animations: {
                 self.centerButton.alpha = 0
                }, completion: { (finished) in
                self.removeFromSuperview()
            })
        }
    }
    
    private func createButton(imageURL: String?) -> UIButton {
        let button = UIButton(type: .Custom)
        if let imageURL = imageURL {
            button.setImage(UIImage(named: imageURL), forState: .Normal)
        }
        button.frame.size = sizeButton
        return button
    }
}
