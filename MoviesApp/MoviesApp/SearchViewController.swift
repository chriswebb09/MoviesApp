//
//  SearchViewController.swift
//  MoviesApp
//
//  Created by Christopher Webb-Orenstein on 1/1/17.
//  Copyright © 2017 Christopher Webb-Orenstein. All rights reserved.
//

import Foundation


import UIKit

final class SearchViewController: UIViewController {
    
    let searchView = SearchView()
    let store = DataStore.sharedInstance
    let loadingView = LoadingView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(searchView)
        searchView.layoutSubviews()
        view.backgroundColor = UIColor.white
        searchView.searchButton.addTarget(self, action: #selector(searchForMovies), for: .touchUpInside)
    }
    
    func searchForMovies() {
        let when = DispatchTime.now() + 2
        
        loadingView.showActivityIndicator(viewController: self)
        if self.searchView.searchField.text!.characters.count > 0 {
            store.searchTerm = ""
            var search = searchView.searchField.text?.components(separatedBy: " ")
            self.store.searchTerm = (search?.remove(at: 0))!
            search?.forEach { term in
                self.store.searchTerm = "\(self.store.searchTerm)+\(term)"
            }
            loadingView.hideActivityIndicator(viewController: self)
            navigationController?.pushViewController(MovieViewController(), animated: false)
        } else {
            DispatchQueue.main.asyncAfter(deadline: when) {
                self.loadingView.hideActivityIndicator(viewController: self)
                
            }
            return
        }
    }
}
