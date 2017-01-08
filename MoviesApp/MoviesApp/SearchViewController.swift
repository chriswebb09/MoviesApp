//
//  SearchViewController.swift
//  MoviesApp
//
//  Created by Christopher Webb-Orenstein on 1/1/17.
//  Copyright © 2017 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

final class SearchViewController: UIViewController {
    
    private let searchView = SearchView()
    fileprivate let store = DataStore.sharedInstance
    private let loadingView = LoadingView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        edgesForExtendedLayout = []
        view.addSubview(searchView)
        searchView.layoutSubviews()
        view.backgroundColor = UIColor.white
        searchView.searchButton.addTarget(self, action: #selector(searchForMovies), for: .touchUpInside)
    }
    
    func searchForMovies() {
        let when = DispatchTime.now() + 0.5
        loadingView.showActivityIndicator(viewController: self)
        if self.searchView.searchField.text!.characters.count > 0 {
            store.searchTerm = ""
            var search = searchView.searchField.text?.components(separatedBy: " ")
            self.store.searchTerm = (search?.remove(at: 0))!
            search?.forEach { [unowned self] term in
                self.store.searchTerm = "\(self.store.searchTerm)+\(term)"
            }
            loadingView.hideActivityIndicator(viewController: self)
            searchView.searchField.text = ""
            navigationController?.pushViewController(MovieViewController(), animated: false)
        } else {
            DispatchQueue.main.asyncAfter(deadline: when) { [unowned self] in 
                self.loadingView.hideActivityIndicator(viewController: self)
            }
            return
        }
    }
}
