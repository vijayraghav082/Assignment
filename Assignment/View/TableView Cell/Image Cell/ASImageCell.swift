//
//  ASImageCell.swift
//  Assignment
//
//  Created by Vijay's Macbook on 21/08/20.
//  Copyright © 2020 Vijay. All rights reserved.
//

import UIKit
import SDWebImage

class ASImageCell: UITableViewCell {
        
    @IBOutlet weak var previewImageView: UIImageView!
    @IBOutlet weak var dimesionLabel: CustomBoldLabel!
    @IBOutlet weak var viewsLabel: CustomRegularLabel!
    @IBOutlet weak var likesLabel: CustomRegularLabel!
    @IBOutlet weak var downloadsLabel: CustomRegularLabel!
        
    var imageDetail: ImageDetail? {
        didSet {
            likesLabel.text = getCountValue(value: imageDetail?.likes ?? 0)
            viewsLabel.text = getCountValue(value: imageDetail?.views ?? 0)
            likesLabel.text = getCountValue(value: imageDetail?.likes ?? 0)
            downloadsLabel.text = getCountValue(value: imageDetail?.downloads ?? 0)
            previewImageView.sd_setImage(with: URL(string: imageDetail?.previewURL ?? ""))
            dimesionLabel.text = "\(imageDetail?.previewHeight ?? 0) x \(imageDetail?.previewWidth ?? 0)"
        }        
    }
    
    func getCountValue(value: Int) -> String {
        if value >= 1000000000 {
            return "\(value / 1000000000)B"
        } else if value >= 1000000 {
            return "\(value / 1000000)M"
        } else if value >= 1000 {
            return "\(value / 1000)K"
        } else {
            return "\(value)"
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        previewImageView.makeRoundCorner(4)
    }
}
