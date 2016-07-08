//
//  MyCircleMenu.swift
//  MyCircleMenu
//
//  Created by Quang Phu on 7/7/16.
//  Copyright © 2016 Quang Phu. All rights reserved.
//

import UIKit


private let size = 60
private let sizeButton = CGSize(width: size, height: size)
private let labelSize = CGSize(width: sizeButton.width, height: 20)

protocol MyCircleMenuDelegate: NSObjectProtocol {
    func titleAtIndex(circleMenu: MyCircleMenu, index: Int) -> String!
    func imageNameAtIndex(circleMenu: MyCircleMenu, index: Int) -> String!
    func numberOfItem(circleMenu: MyCircleMenu) -> Int!
}

class MyCircleMenu: UIView {
    weak var delegate: MyCircleMenuDelegate? {
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
//        self.alpha = 0
//        UIView.animateWithDuration(0.6, animations: { () -> Void in
//            self.alpha = 1
//        }) { (complete) -> Void in
//            self.startAnimationForView()
//        }
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
    
    // MARK: Public Function
    func show() {
        self.alpha = 0
        UIView.animateWithDuration(0.6, animations: { () -> Void in
            self.alpha = 1
        }) { (complete) -> Void in
            self.startAnimationForView()
        }
    }
}


//protocol MyCircleMenuDelegate {
//    func getPhotoFotItemAtIndex(view: MyCircleMenu, index: Int) -> String!
//    func getNameForItemAtIndex(view: MyCircleMenu, index: Int) -> String!
//    
//}
//
//private let buttonWidth = 60
//private let buttonSize = CGSize(width: buttonWidth, height: buttonWidth)
//private let labelSize = CGSize(width: buttonWidth, height: 30)
//
//class MyCircleMenu: UIView {
//
//    // MARK: IBOulet & IBAction
//    
//    
//    // MARK: Property
//    let heightButton1 = 60
//    let duration = 0.5
//    let numberItems = 5
//    
//    var subMenus: [UIView] = []
//    var cancelButton: UIButton?
//    
//    var photos = ["but2.png","but1.png","but3.png","but4.png","but5.png"]
//    var nameSubMenu = ["Edit","Home","Detail","Friend","Family"]
//    var r: Double = 0
//    
//    var delegate: MyCircleMenuDelegate? {
//        didSet {
//            self.configItems()
//        }
//    }
//    
////    var delegate: MyCircleMenuDelegate?
//    
//    // MARK: Init function for uiview
//    convenience init(frame: CGRect, r: Double) {
//        self.init(frame: frame)
//        self.configView(frame, r: r)
//    }
//
//    
//    
//    // MARK: Private function
//    func configView(frame: CGRect, r: Double) {
//        self.r = r
//
//        self.backgroundColor = UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 0.7)
//        
//        self.cancelButton = createButton(self.center, imageURL: "circle_close.png", index: 99)
//        self.cancelButton!.addTarget(self, action: #selector(MyCircleMenu.cancelButtonDidTap(_:)), forControlEvents: .TouchUpInside)
//        self.addSubview(self.cancelButton!)
//        
//    }
//    
//    func configItems() {
//        // Load submenu
//        for i in 0..<self.numberItems {
//            
//            let subMenu = UIView()
//            subMenu.frame.size = CGSize(width: buttonWidth, height: buttonWidth + 30)
//            subMenu.center = self.center
//            subMenu.clipsToBounds = true
//            print("\(subMenu.center)")
//            //            subMenu.backgroundColor = UIColor.redColor()
//            
//            let imageURL = self.delegate?.getPhotoFotItemAtIndex(self, index: i)
//            let button = createButton(CGPoint(x: subMenu.bounds.width / 2, y: subMenu.bounds.height / 2), imageURL: imageURL, index: i)
//            button.addTarget(self, action: #selector(MyCircleMenu.didTapButton(_:)), forControlEvents: .TouchUpInside)
//            subMenu.addSubview(button)
//            
//            
//            let label = UILabel(frame: CGRect(origin: CGPoint(x: 0, y: buttonWidth), size: labelSize))
//            label.text = self.delegate?.getNameForItemAtIndex(self, index: i)
//            label.textAlignment = .Center
//            label.adjustsFontSizeToFitWidth = true
//            
//            subMenu.addSubview(label)
//            subMenu.transform = CGAffineTransformMakeScale(0.0, 0.0)
//            
//            subMenus.append(subMenu)
//            self.addSubview(subMenu)
//        }
//        
//        UIView.animateWithDuration(0.5, animations: {
//            self.alpha = 1.0
//        }) { (completed) in
//            self.showOut()
//        }
//    }
//    
//    func createButtonWith(origin: CGPoint, size: CGSize, index: Int) -> UIButton {
//        let button = UIButton(type: .Custom)
//        button.frame.size = size
//        button.center = origin
//        let photo = self.delegate?.getPhotoFotItemAtIndex(self, index: index)
//        button.setImage(UIImage(named: photo!), forState: .Normal)
//        button.tag = index
//        return button
//    }
//    
//    private func createButton(origin: CGPoint, imageURL: String?, index: Int) -> UIButton {
//        let button = UIButton(type: .Custom)
//        button.center = origin
//        if let imageURL = imageURL {
//            button.setImage(UIImage(named: imageURL), forState: .Normal)
//        }
//        button.bounds.size = buttonSize
//        button.tag = index
//        return button
//    }
//    
//    // MARK: button function
//    func cancelButtonDidTap(sender: UIButton) {
//        
//        UIView.animateWithDuration(0.9, animations: {
//            for item in self.subMenus {
//                item.center = self.center
//                item.transform = CGAffineTransformMakeScale(0.01, 0.01)
//            }
//        }) { (complete) -> Void in
//            UIView.animateWithDuration(0.5, delay: 0.3, options: .TransitionNone, animations: {
//                self.alpha = 0
//                }, completion: { (finished) in
//                self.removeFromSuperview()
//            })
//        }
//        
//    }
//    
//    func didTapButton(sender: UIButton) {
//        self.cancelButton?.alpha = 0
//        for i in 0..<self.numberItems {
//            self.subMenus[i].alpha = 0
//        }
//        self.subMenus[sender.tag].alpha = 1
//        self.subMenus[sender.tag].bounds.size = buttonSize
//        
//        UIView.animateWithDuration(0.9, animations: {
//            
//            self.subMenus[sender.tag].center = self.center
//        }) { (complete) -> Void in
//            UIView.animateWithDuration(0.5, delay: 0.3, options: .TransitionNone, animations: {
//                self.alpha = 0
//                }, completion: { (finished) in
//                    self.removeFromSuperview()
//            })
//        }
//    }
//    
//    func zoomOut(newLocation: CGPoint) {
//         UIView.animateWithDuration(1, delay: 0.0, options: [.CurveLinear], animations: { () -> Void in
//            self.transform = CGAffineTransformIdentity
//            self.center = newLocation
//        }) { (animationCompleted: Bool) -> Void in
//            
//        }
//    }
//    
//    func showOut() {
//        for i in 0..<self.numberItems {
//            UIView.animateWithDuration(1, delay: 0.0, options: [.CurveLinear], animations: { () -> Void in
//                self.subMenus[i].transform = CGAffineTransformIdentity
//                self.subMenus[i].center = self.getPointForItemAtIndex(i)
//            }) { (animationCompleted: Bool) -> Void in
//                
//            }
//        }
//
//    }
//    
//    
//    func getPointForItemAtIndex(index: Int) -> CGPoint{
//        
//        let ox = Double(center.x)
//        let oy = Double(center.y)
//        
//        let itemCorner = 360 / Double(numberItems)
//        let nextCorner = Double(index) * itemCorner
//        
//        let x = self.r * sin(nextCorner * M_PI / 180)
//        let y = self.r * cos(nextCorner * M_PI / 180)
//    
//        return CGPoint(x: ox + x, y: oy - y)
//    }
//    
//
//    
//    // MARK: Public function
//}

