//
//  SearchView.swift
//  MoviesApp
//
//  Created by Christopher Webb-Orenstein on 1/1/17.
//  Copyright © 2017 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

final class SearchView: UIView {
    
    // =============================
    // MARK: - UI Elements
    // =============================
    
    deinit {
        print("deallocating search view")
    }
    
    let headerLabel: UILabel = {
        let friendsHeaderLabel = UILabel()
        friendsHeaderLabel.textColor = UIColor.black
        friendsHeaderLabel.text = "Search For Movies"
        friendsHeaderLabel.font = Constants.Font.bolderFontLarge
        friendsHeaderLabel.textAlignment = .center
        friendsHeaderLabel.layer.masksToBounds = true
        return friendsHeaderLabel
    }()
    
    var searchField: TextFieldExtension = {
        let searchField = TextFieldExtension()
        searchField.placeholder = "Movie title"
        searchField.font = Constants.signupFieldFont
        searchField.layer.borderColor = UIColor.lightGray.cgColor
        searchField.layer.cornerRadius = Constants.searchFieldButtonRadius
        searchField.layer.borderWidth = Constants.borderWidth
        return searchField
    }()
    
    var searchButton: UIButton = {
        var searchButton = UIButton()
        searchButton.layer.borderWidth = Constants.borderWidth
        searchButton.layer.borderColor = UIColor.white.cgColor
        searchButton.backgroundColor = Constants.buttonColor
        searchButton.layer.cornerRadius = Constants.searchFieldButtonRadius
        searchButton.setTitle("Search", for: .normal)
        searchButton.setTitleColor(UIColor.white, for: .normal)
        return searchButton
    }()
    
}

extension SearchView {
    
    // =============================
    // MARK: - Initialization
    // =============================
    
    override func layoutSubviews() {
        super.layoutSubviews()
        frame = UIScreen.main.bounds
        setupConstraints()
    }
    
    // =============================
    // MARK: - Configure
    // =============================
    
    private func configureView(view:UIView) {
        addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.widthAnchor.constraint(equalTo:widthAnchor, multiplier: Constants.searchFieldWidth).isActive = true
        view.heightAnchor.constraint(equalTo:heightAnchor, multiplier: Constants.buttonHeight).isActive = true
        view.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
    
    private func setupConstraints() {
        configureView(view: headerLabel)
        headerLabel.topAnchor.constraint(equalTo: topAnchor, constant: bounds.height * Constants.headerLabelTopOffset).isActive = true
        
        configureView(view: searchField)
        searchField.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: bounds.height * 0.16).isActive = true
        
        addSubview(searchButton)
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        searchButton.widthAnchor.constraint(equalTo:widthAnchor, multiplier: 0.4).isActive = true
        searchButton.heightAnchor.constraint(equalTo:heightAnchor, multiplier: Constants.buttonHeight).isActive = true
        searchButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        searchButton.topAnchor.constraint(equalTo: searchField.bottomAnchor, constant: bounds.height * 0.12).isActive = true
    }
}




