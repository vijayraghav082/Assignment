//
//  ASImageListVC+TableView.swift
//  Assignment
//
//  Created by Vijay's Macbook on 21/08/20.
//  Copyright © 2020 Vijay. All rights reserved.
//

import UIKit

extension ASImageListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == suggestionTableView {
            return suggestionArray.count
        } else {
            let count = imageModel?.hits.count ?? 0
            if loadMoreData {
                return count + 1
            } else {
                return count
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == suggestionTableView {
            return 37
        }
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == suggestionTableView {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.ASSuggestionCell, for: indexPath) as? ASSuggestionCell else {
                return UITableViewCell()
            }
            cell.textLabel?.text = suggestionArray[indexPath.row]
            return cell
        } else {
            if loadMoreData && indexPath.row == tableView.numberOfRows(inSection: 0) - 1 {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.ASIndicatorCell) as? ASIndicatorCell else {
                    return UITableViewCell()
                }
                if loadMoreData {
                    cell.startAnimating()
                    cell.isHidden = false
                } else {
                    cell.stopAnimating()
                    cell.isHidden = true
                }
                return cell
            } else {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.ASImageCell, for: indexPath) as? ASImageCell else {
                    return UITableViewCell()
                }
                cell.imageDetail = imageModel?.hits[indexPath.row]
                return cell
            }
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if tableView == imageTableView {
            if indexPath.row == tableView.numberOfRows(inSection: 0) - 1 && loadMoreData{
                loadMoreData = false
                getImageList(isNewSearch: false)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == imageTableView {
            let imageSliderVC = ASImageSliderVC.instantiate(fromAppStoryboard: .main)
            imageSliderVC.imagesArray = imageModel?.hits ?? []
            imageSliderVC.selectedIndex = indexPath.row
            getMainQueue { [weak self] in
                self?.navigationController?.pushViewController(imageSliderVC, animated: true)
            }
        } else {
            pageIndex = 1
            getMainQueue { [weak self] in                
                self?.waterMarkLabel.isHidden = true
                self?.suggestionTableView.isHidden = true
                self?.searchController.searchBar.endEditing(true)
                self?.searchController.searchBar.text = self?.suggestionArray[indexPath.row]
            }
            delay(time: 0.1) { [weak self] in
                self?.getImageList(isNewSearch: true)
            }
        }
    }
}
