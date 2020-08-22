//
//  ASImageSliderVC.swift
//  Assignment
//
//  Created by Mobilecoderz on 22/08/20.
//  Copyright © 2020 Vijay. All rights reserved.
//

import UIKit

class ASImageSliderVC: UIViewController {

    var currentPage = 0
    var selectedIndex = 0
    var imagesArray: [ImageDetail] = []
        
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var nextImage: UIImageView!
    @IBOutlet weak var previousButton: UIButton!
    @IBOutlet weak var previousImage: UIImageView!
    @IBOutlet weak var imageCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }
    
    private  func initialSetup() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: kScreenWidth - 40, height: kScreenHeight - (navigationController?.navigationBar.frame.size.height)! - 40)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumLineSpacing = 0.0
        layout.minimumInteritemSpacing = 0.0
        imageCollectionView.setCollectionViewLayout(layout, animated: false)
        
        if imagesArray.count == 0 || imagesArray.count == 1 {
            //Do nothing
        } else if imagesArray.count >= 2 {
            nextButton.isHidden = false
            nextImage.isHidden = false
        }
        previousButton.addTarget(self, action: #selector(previousButtonAction(_:)), for: .touchUpInside)
        nextButton.addTarget(self, action: #selector(nextButtonAction(_:)), for: .touchUpInside)
        imageCollectionView.reloadData()
        navigationController?.navigationBar.tintColor = .black
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if imagesArray.count > 0 {
            delay(time: 0.1) { [weak self] in
                self?.imageCollectionView.scrollToItem(at: IndexPath(item: self?.selectedIndex ?? 0, section: 0), at: .right, animated: false)
            }
        }
    }
}

