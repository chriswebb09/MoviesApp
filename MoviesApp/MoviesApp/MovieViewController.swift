//
//  MovieViewController.swift
//  MoviesApp
//
//  Created by Christopher Webb-Orenstein on 12/30/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

class TeamViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    private let reuseIdentifier = "MovieCell"
    let store = DataStore.sharedInstance
    var collectionView : UICollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
    let detailPop = DetailPopover()
   // var searchController = UISearchController(searchResultsController: nil)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        edgesForExtendedLayout = []
        setupCollectionView()
        //navigationController?.navigationBar.addSubview(searchController.searchBar)
        let client = APIClient()
        client.sendAPICall(fromUrlString:"http://www.omdbapi.com/?s=Batman&page=2", completion: { movies in
            
        })
        collectionView.dataSource = self
        collectionView.delegate = self
        print(self.store.movies)
        //collectionView.h
       // setupNavigationController(navController: self.navigationController!)
        collectionView.register(MovieCell.self, forCellWithReuseIdentifier: MovieCell.reuseIdentifier)
        collectionView.backgroundColor = UIColor(red:0.97, green:0.97, blue:0.97, alpha:1.0)
        view.addSubview(collectionView)
        collectionView.reloadData()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Search", style: .plain, target: self, action: #selector(searchButtonPressed))
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        collectionView.collectionViewLayout.invalidateLayout()
    }
}

extension TeamViewController {
    
    func searchButtonPressed() {
        print("search button pressed")
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        
    }
    
    func setupCollectionView() {
        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .vertical
            flowLayout.minimumLineSpacing = 0
        }
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        collectionView.collectionViewLayout.invalidateLayout()
        layout.sectionInset = UIEdgeInsets(top:0, left: 0, bottom: 60, right: 0)
        layout.itemSize = CGSize(width: 50, height: 150)
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
    }
    
    // MARK: - Setup navbar UI
}

extension TeamViewController {
    
    // MARK: - CollectionViewController method implementations
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height/3.2)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.store.movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCell.reuseIdentifier, for: indexPath) as! MovieCell
        cell.configureCell(movie:self.store.movies[indexPath.row])
        //cell.teamMemberBioText.isHidden = true
        return cell
    }
}

extension TeamViewController {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top:0, left: 0, bottom: 60, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumItemSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    // MARK: - Popvoer view implmented
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let memberData = self.store.movies[indexPath.row]
        detailPop.popView.configureView(movie: memberData)
        UIView.animate(withDuration: 0.15, animations: {
            self.detailPop.showPopView(viewController: self)
            self.detailPop.popView.isHidden = false
            let zoomOutTranform: CGAffineTransform = CGAffineTransform(scaleX: 10, y: 10)
            // self.detailPop.popView.bioTextView.text = memberData.bio
        })
        self.detailPop.popView.doneButton.addTarget(self, action: #selector(hidePop), for: .touchUpInside)
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        detailPop.hidePopView(viewController: self)
    }
    
    func hidePop() {
        detailPop.hidePopView(viewController: self)
        detailPop.popView.isHidden = true
        view.sendSubview(toBack: detailPop)
    }
    
}

