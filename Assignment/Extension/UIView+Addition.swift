//
//  UIView+Addition.swift
//  Shift Vendor
//
//  Created by Vijay's Macbook on 21/08/20.
//  Copyright © 2020 Vijay. All rights reserved.
//

import UIKit

extension UIView {
    
    func makeRoundCorner(_ radius:CGFloat) {
        clipsToBounds = true
        layer.cornerRadius = radius
    }
    
    func roundCorner(corners: CACornerMask, radius: Double) {
        layer.cornerRadius = CGFloat(radius)
        layer.maskedCorners = corners
    }
}

extension UIView {
    
    @IBInspectable var shadow: Bool {
        get {
            return layer.shadowOpacity > 0.0
        }
        set {
            if newValue == true {
                self.addShadow()
            }
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return self.layer.cornerRadius
        }
        set {
            self.layer.cornerRadius = newValue
            if shadow == false {
                self.layer.masksToBounds = true
            }
        }
    }
    
    func addShadow(shadowColor: UIColor = .black,
                   shadowOffset: CGSize = CGSize(width: 1.0, height: 2.0),
                   shadowOpacity: Float = 0.4,
                   shadowRadius: CGFloat = 3.0) {
        clipsToBounds = false
        layer.masksToBounds = false
        layer.shadowColor = shadowColor.cgColor
        layer.shadowOffset = shadowOffset
        layer.shadowOpacity = shadowOpacity
        layer.shadowRadius = shadowRadius
    }
}
