//
//  UIView+Extension.swift
//  Point City
//
//  Created by Faheem on 01/05/2020.
//  Copyright © 2020 Crymzee Networks. All rights reserved.
//

import UIKit

extension UIView {
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
    
    @IBInspectable var showShadow: Bool {
        get {
            return false
        }
        set {
            if newValue {
                self.dropShadow()
            }
        }
    }

    
    func setBorderLayer(width: CGFloat, color: UIColor, cornerRadius:CGFloat? = nil) {
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = width
        
        if let radius = cornerRadius {
            self.layer.cornerRadius = radius
        }else {
            self.layer.cornerRadius = self.bounds.size.width / 2
        }
    }
    
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        if #available(iOS 11.0, *) {
            clipsToBounds = true
            layer.cornerRadius = radius
            layer.maskedCorners = CACornerMask(rawValue: corners.rawValue)
        } else {
            let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
            let mask = CAShapeLayer()
            mask.path = path.cgPath
            layer.mask = mask
        }
    }
    
    func dropShadow(radius: CGFloat? = 1 , opacity: Float? = 1) {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOpacity = opacity!
        layer.shadowOffset = CGSize(width: 0, height: radius!)
        layer.shadowRadius = radius!
    }
    
    // OUTPUT 2
    func dropShadow(color: UIColor = .black, opacity: Float = 0.5, offSet: CGSize = CGSize(width: -1, height: 1), radius: CGFloat = 1, scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offSet
        layer.shadowRadius = radius
    }
    
}
