//
//  ASImageListVC.swift
//  Assignment
//
//  Created by Vijay's Macbook on 21/08/20.
//  Copyright © 2020 Vijay. All rights reserved.
//

import UIKit

class ASImageListVC: UIViewController {
    
    var pageIndex = 1
    var loadMoreData = false
    var imageModel: ImageModel?
    var searchController: UISearchController!
    let apiQueue = DispatchQueue(label: "ApiQueue", qos: .background)
            
    var suggestionArray: [String] {
        get {
            kUserDefault.value(forKey: UserDefaultsKeys.kSearchKeywordArray) as? [String] ?? []
        }
    }
   
    var hasTopNotch: Bool {
        return UIApplication.shared.delegate?.window??.safeAreaInsets.top ?? 0 > 20
    }
        
    @IBOutlet weak var imageTableView: UITableView!
    @IBOutlet weak var waterMarkLabel: CustomBoldLabel!
    @IBOutlet weak var suggestionTableView: UITableView!
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
        configureSearchController()
    }
        
    private func initialSetup() {
        //TableView Setup
        indicatorView.startAnimating()
        imageTableView.estimatedRowHeight = 280
        imageTableView.rowHeight = UITableView.automaticDimension
        suggestionTableView.estimatedRowHeight = 40
        suggestionTableView.rowHeight = UITableView.automaticDimension
        imageTableView.register(UINib(nibName: CellIdentifier.ASImageCell, bundle: Bundle.main), forCellReuseIdentifier: CellIdentifier.ASImageCell)
        imageTableView.register(UINib(nibName: CellIdentifier.ASIndicatorCell, bundle: Bundle.main), forCellReuseIdentifier: CellIdentifier.ASIndicatorCell)
        waterMarkLabel.text = "Find your favourites images here!"
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        suggestionTableView.roundCorner(corners: [.layerMaxXMinYCorner, .layerMinXMaxYCorner], radius: 8)
        suggestionTableView.addShadow(shadowColor: .darkGray, shadowOffset: CGSize(width: 3, height: 3), shadowOpacity: 0.4, shadowRadius: 3)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        getMainQueue { [weak self] in
            self?.searchController.searchBar.endEditing(true)
        }
    }
    
    private func configureSearchController() {
        //Search bar setup
        searchController = UISearchController(searchResultsController: nil)
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search here"
        searchController.searchBar.delegate = self
        searchController.searchBar.sizeToFit()
        extendedLayoutIncludesOpaqueBars = true
        navigationItem.searchController = searchController
    }
}

