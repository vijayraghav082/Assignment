//
//  UILabel+Addition.swift
//  Shift Vendor
//
//  Created by Vijay's Macbook on 21/08/20.
//  Copyright © 2020 Vijay. All rights reserved.
//

import UIKit

class CustomRegularLabel: UILabel {
    override func awakeFromNib() {
        super.awakeFromNib()
        let size: CGFloat = CGFloat(tag == 0 ? 16 : tag)
        font = UIFont.kAppDefaultFontRegular(ofSize: size)
    }
}

class CustomBoldLabel: UILabel {
    override func awakeFromNib() {
        super.awakeFromNib()
        let size: CGFloat = CGFloat(tag == 0 ? 16 : tag)
        font = UIFont.kAppDefaultFontBold(ofSize: size)
    }
}


