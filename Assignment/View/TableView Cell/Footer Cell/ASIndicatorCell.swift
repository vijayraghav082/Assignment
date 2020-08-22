//
//  ASIndicatorCell.swift
//  Assigment
//
//  Created by Vijay's Macbook on 22/08/2020
//  Copyright © 2020 Vijay. All rights reserved.
//

import UIKit

class ASIndicatorCell: UITableViewCell {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func startAnimating() {
        activityIndicator.startAnimating()
    }
    
    func stopAnimating() {
        activityIndicator.stopAnimating()
    }
}
