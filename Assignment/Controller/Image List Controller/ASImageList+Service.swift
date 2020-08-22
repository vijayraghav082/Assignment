//
//  ASImageListVC+Service.swift
//  Assignment
//
//  Created by Vijay's Macbook on 21/08/20.
//  Copyright © 2020 Vijay. All rights reserved.
//

import UIKit

extension ASImageListVC {
            
    func getImageList(isNewSearch: Bool) {
        let searchText = searchController.searchBar.text!.replacingOccurrences(of: " ", with: "+")
        let endPoint = "q=\(searchText)&page=\(pageIndex)"
        if isNewSearch {
            indicatorView.startAnimating()
            indicatorView.isHidden = false
            /******Special note*******/
            //Normally I used any third party loader but here if have not used any third party library that's why I have diabled the interaction.
            view.alpha = 0.8
            view.isUserInteractionEnabled = false
        }
        
        APIManager.fetchDataFromWeb(apiQueue: apiQueue, endPoint: endPoint) { [weak self] (data: ImageModel?, error: Error?) in
            self?.getMainQueue { [weak self] in
                if isNewSearch {
                    self?.indicatorView.stopAnimating()
                    self?.indicatorView.isHidden = true
                    self?.view.alpha = 1
                    self?.view.isUserInteractionEnabled = true
                }
                self?.handleResponse(data: data, error: error)
            }
        }
    }

    func handleResponse(data: ImageModel?, error: Error?) {
        if let apiError = error {
            waterMarkLabel.isHidden = false
            waterMarkLabel.text = apiError.localizedDescription
        } else if let serverResponse = data {
            if pageIndex == 1 {
                imageModel = serverResponse
                if (imageModel?.hits.count ?? 0) > 0 {
                    loadMoreData = true
                    waterMarkLabel.isHidden = true
                    kUserDefault.setSearchKeyword(searchController.searchBar.text!)
                } else {
                    waterMarkLabel.text = "No Images Found\n Try with different Tag!"
                    waterMarkLabel.isHidden = false
                }
            } else {
                if serverResponse.hits.count > 0 {
                    imageModel?.hits.append(contentsOf: serverResponse.hits)
                    loadMoreData = true
                }
            }
            pageIndex += 1
            getMainQueue { [weak self] in
                self?.indicatorView.stopAnimating()
                self?.indicatorView.isHidden = true
                self?.imageTableView.reloadData()
            }
        }
    }
}

