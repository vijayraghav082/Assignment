//
//  ASImagePreviewCell.swift
//  Assignment
//
//  Created by Mobilecoderz on 22/08/20.
//  Copyright © 2020 Vijay. All rights reserved.
//

import UIKit

import SDWebImage

class ASImagePreviewCell: UICollectionViewCell {
    
    @IBOutlet weak var previewImageView: UIImageView!
    
    var imageDetail: ImageDetail? {
        didSet {
            previewImageView.sd_setImage(with: URL(string: imageDetail?.largeImageURL ?? ""))
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        previewImageView.enableZoom()
    }
}
