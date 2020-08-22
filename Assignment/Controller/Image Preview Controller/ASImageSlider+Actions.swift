//
//  ASImageSlider+Actions.swift
//  Assignment
//
//  Created by Mobilecoderz on 22/08/20.
//  Copyright © 2020 Vijay. All rights reserved.
//

import UIKit

extension ASImageSliderVC {
    @objc func previousButtonAction(_ sender: UIButton) {
        let indexPath = IndexPath(row: currentPage - 1, section: 0)
        guard currentPage > 0 else { return }
        imageCollectionView.scrollToItem(at: indexPath, at: .left, animated: true)
    }
    
    @objc func nextButtonAction(_ sender: UIButton) {
        let indexPath = IndexPath(row: currentPage + 1, section: 0)
        guard currentPage < imagesArray.count - 1 else { return }
        imageCollectionView.scrollToItem(at: indexPath, at: .left, animated: true)
    }
}
