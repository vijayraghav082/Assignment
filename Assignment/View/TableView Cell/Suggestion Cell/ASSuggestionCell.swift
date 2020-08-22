//
//  ASSuggestionCell.swift
//  Assignment
//
//  Created by Mobilecoderz on 22/08/20.
//  Copyright © 2020 Vijay. All rights reserved.
//

import UIKit

class ASSuggestionCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        textLabel?.font = UIFont.kAppDefaultFontBold(ofSize: 13)
    }
}
