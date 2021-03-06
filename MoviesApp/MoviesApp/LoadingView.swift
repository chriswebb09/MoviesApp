//
//  LoadingView.swift
//  MoviesApp
//
//  Created by Christopher Webb-Orenstein on 1/1/17.
//  Copyright © 2017 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

class LoadingView: UIView {
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.activityIndicatorViewStyle = .whiteLarge
        return activityIndicator
    }()
    
    private lazy var containerView: UIView = {
        let containerView = UIView()
        containerView.backgroundColor = UIColor.clear
        return containerView
    }()
    
    lazy var loadingView: UIView = {
        let loadingView = UIView()
        loadingView.layer.cornerRadius = 10
        loadingView.backgroundColor = UIColor(red:0.27, green:0.27, blue:0.27, alpha:0.8)
        return loadingView
    }()
    
    public func showActivityIndicator(viewController: UIViewController) {
        
        containerView.frame = UIScreen.main.bounds
        containerView.center = CGPoint(x: UIScreen.main.bounds.width/2, y: UIScreen.main.bounds.height/2.5)
        loadingView.frame = CGRect(x:0, y:0, width:70, height:70)
        loadingView.center = CGPoint(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.midY)
        loadingView.clipsToBounds = true
        activityIndicator.frame = CGRect(x:0.0, y:0.0, width:40.0, height:40.0)
        activityIndicator.center = CGPoint(x:loadingView.frame.size.width / 2,
                                           y:loadingView.frame.size.height / 2)
        
        loadingView.addSubview(activityIndicator)
        containerView.addSubview(loadingView)
        viewController.view.addSubview(containerView)
        loadingView.isHidden = false
        activityIndicator.startAnimating()
    }
    
    public func hideActivityIndicator(viewController:UIViewController){
        viewController.view.sendSubview(toBack: containerView)
        loadingView.isHidden = true
        activityIndicator.stopAnimating()
    }
}



