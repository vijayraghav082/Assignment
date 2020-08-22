//
//  ASImageListVC+SearchDelegates.swift
//  Assignment
//
//  Created by Mobilecoderz on 22/08/20.
//  Copyright © 2020 Vijay. All rights reserved.
//

import UIKit

extension ASImageListVC: UISearchControllerDelegate, UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        if suggestionArray.count > 0 {
            suggestionTableView.isHidden = false
            let tableHeight = suggestionArray.count * 37 + 10
            heightConstraint.constant = CGFloat(tableHeight)
            if !hasTopNotch {
                topConstraint.constant = 2
            }
            UIView.animate(withDuration: 0.2) { [weak self] in
                self?.getMainQueue { [weak self] in
                    self?.view.bringSubviewToFront((self?.suggestionTableView)!)
                    self?.suggestionTableView.layoutIfNeeded()
                    self?.view.layoutIfNeeded()
                    self?.suggestionTableView.reloadData()
                }
            }
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        suggestionTableView.isHidden = true
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        suggestionTableView.isHidden = true
        if let text = searchBar.text, text.isValidSearchText() {
            pageIndex = 1
            waterMarkLabel.isHidden = true            
            getImageList(isNewSearch: true)
        } else {
            waterMarkLabel.text = ValidationMessage.invalidSearchTag
        }
    }
}
