//
//  UIView.swift
//  AT-QuangPCM
//
//  Created by Quang Phu on 7/11/16.
//  Copyright © 2016 demo. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    func border(radius: CGFloat, width: CGFloat? = nil, color: UIColor? = nil) {
        layer.cornerRadius = radius
        layer.masksToBounds = true
        guard let width = width, color = color else { return }
        layer.borderWidth = width
        layer.borderColor = color.CGColor
    }
    
    func addTopBorderWithColor(color: UIColor? = nil, andWidth borderWidth: CGFloat? = nil) {
        let border = CALayer()
        guard let color = color, borderWidth = borderWidth else {
            return
        }
        border.backgroundColor = color.CGColor;
        border.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: borderWidth);
        self.layer.addSublayer(border)
    }
    
    func addBottomBorderWithColor(color: UIColor? = nil, andWidth borderWidth: CGFloat? = nil) {
        let border = CALayer()
        guard let color = color, borderWidth = borderWidth else {
            return
        }
        border.backgroundColor = color.CGColor;
        border.frame = CGRect(x: 0, y: self.frame.size.height - borderWidth, width: self.frame.size.width, height: borderWidth);
        self.layer.addSublayer(border)
    }
    
    func addRightBorderWithColor(color: UIColor? = nil, andWidth borderWidth: CGFloat? = nil) {
        let border = CALayer()
        guard let color = color, borderWidth = borderWidth else {
            return
        }
        border.backgroundColor = color.CGColor;
        border.frame = CGRect(x: self.frame.size.width - borderWidth, y: 0, width: borderWidth, height: self.frame.size.height);
        self.layer.addSublayer(border)
    }
    
    func addLeftBorderWithColor(color: UIColor? = nil, andWidth borderWidth: CGFloat? = nil) {
        let border = CALayer()
        guard let color = color, borderWidth = borderWidth else {
            return
        }
        border.backgroundColor = color.CGColor;
        border.frame = CGRect(x: 0, y: 0, width: borderWidth, height: self.frame.size.height);
        self.layer.addSublayer(border)
    }
}


// MARK: ---------------- String --------------

enum ValidateType: String {
    case Email = "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$"
    case Phone = "^d"
}

extension String {
    func isValid(type: ValidateType) -> Bool {
        let test = NSPredicate(format:"SELF MATCHES %@", type.rawValue)
        return test.evaluateWithObject(self)
    }
}

