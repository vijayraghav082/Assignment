//
//  ASImageSlider+CollectionView.swift
//  Assignment
//
//  Created by Mobilecoderz on 22/08/20.
//  Copyright © 2020 Vijay. All rights reserved.
//

import UIKit

extension ASImageSliderVC: UICollectionViewDelegate, UICollectionViewDataSource  {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imagesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifier.ASImagePreviewCell, for: indexPath) as? ASImagePreviewCell else {
            return UICollectionViewCell()
        }
        cell.previewImageView.setDefaultTransform()
        cell.imageDetail = imagesArray[indexPath.row]
        return cell
    }
}

extension ASImageSliderVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: kScreenWidth, height: kScreenHeight - (navigationController?.navigationBar.frame.size.height)!)
    }
}
