//
//  MovieViewController2.swift
//  MoviesApp
//
//  Created by Christopher Webb-Orenstein on 12/31/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

class MovieViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    private let reuseIdentifier = "MovieCell"
    var loadingView = LoadingView()
    let store = DataStore.sharedInstance
    let detailPop = DetailPopover()
    let client = APIClient()
    var collectionView : UICollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        edgesForExtendedLayout = []
        setupCollectionView()
        loadMovieData()
        print(self.store.movies)
        addDelegatesToView()
        collectionView.backgroundColor = UIColor(red:0.97, green:0.97, blue:0.97, alpha:1.0)
        view.addSubview(collectionView)
        setupNavigationController(navController: self.navigationController!)
        print(self.store.movies)
        //collectionView.reloadData()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        collectionView.collectionViewLayout.invalidateLayout()
    }
}

extension MovieViewController {
    
    func loadMovieData() {
        client.sendAPICall(fromUrlString:"http://www.omdbapi.com/?s=\(store.searchTerm)&page=2", completion: { movies in
            self.loadingView.showActivityIndicator(viewController: self)
            if self.store.movies.count > 0 {
                self.store.movies.removeAll()
            }
            self.store.movies.append(contentsOf: movies)
            DispatchQueue.main.async {
                self.loadingView.hideActivityIndicator(viewController: self)
                self.collectionView.reloadData()
            }
        })
    }
    
    
    func addDelegatesToView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(MovieCell.self, forCellWithReuseIdentifier: MovieCell.reuseIdentifier)
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
}

extension MovieViewController {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.store.movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCell.reuseIdentifier, for: indexPath) as! MovieCell
        cell.configureCell(movie:self.store.movies[indexPath.row])
        return cell
    }
}

extension MovieViewController {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height/3.5)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top:0, left: 0, bottom: 60, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumItemSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
}

extension MovieViewController {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let memberData = self.store.movies[indexPath.row]
        
        detailPop.popView.configureView(movie: memberData)
        UIView.animate(withDuration: 0.15, animations: {
            self.detailPop.showPopView(viewController: self)
            self.detailPop.popView.isHidden = false
            let zoomOutTranform: CGAffineTransform = CGAffineTransform(scaleX: 1, y: 1)
            self.detailPop.popView.transform = zoomOutTranform
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

