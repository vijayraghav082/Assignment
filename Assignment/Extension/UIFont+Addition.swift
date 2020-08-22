//
//  UIFont+Extension.swift
//  Verkoop
//
//  Created by Vijay's Macbook on 21/08/20.
//  Copyright © 2020 MobileCoderz. All rights reserved.
//

import UIKit

extension UIFont {
    
    static let widthFactor = (UIScreen.main.bounds.width / 320) > 1.2 ? 1.2 : (UIScreen.main.bounds.width / 320)
    
    static func kAppDefaultFontBold(ofSize size: CGFloat = 16) -> UIFont {
        return UIFont.boldSystemFont(ofSize: size * widthFactor)
    }
    
    static func kAppDefaultFontRegular(ofSize size: CGFloat = 16) -> UIFont {
        return UIFont.systemFont(ofSize: size * widthFactor)
    }
}
