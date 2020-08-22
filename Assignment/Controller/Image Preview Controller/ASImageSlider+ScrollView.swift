//
//  ASImageSlider+ScrollView.swift
//  Assignment
//
//  Created by Mobilecoderz on 22/08/20.
//  Copyright © 2020 Vijay. All rights reserved.
//

import UIKit

extension ASImageSliderVC {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageWidth = scrollView.frame.width
        currentPage = Int((scrollView.contentOffset.x + pageWidth / 2) / pageWidth)
        
        /******Special note*******/
        //I don't hav the perfect image for backward and forward icon so I used the image and button,
        //Image is redundant here , we can set the image in button, but UI is not looking nice, that's why I have used the image
        if currentPage == imagesArray.count - 1 {
            nextImage.isHidden = true
            nextButton.isHidden = true
        } else if currentPage == 0 {
            previousImage.isHidden = true
            previousButton.isHidden = true
        } else {
            nextImage.isHidden = false
            nextButton.isHidden = false
            previousImage.isHidden = false
            previousButton.isHidden = false
        }
     }
}
