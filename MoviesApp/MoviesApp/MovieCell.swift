//
//  MovieCell.swift
//  MoviesApp
//
//  Created by Christopher Webb-Orenstein on 12/30/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

class MovieCell: UICollectionViewCell {
    var client = APIClient()
    
    static let reuseIdentifier = "Cell"
    
    deinit {
        print("deallocating moviecell")
    }
    
    lazy var posterView: UIImageView = {
        var posterView = UIImageView()
        posterView.layer.borderWidth = 2
        posterView.clipsToBounds = true
        return posterView
    }()
    
    lazy var movieTitleLabel: UILabel = {
        var movieTitleLabel = UILabel()
        movieTitleLabel.font = UIFont(name: "HelveticaNeue", size: 18)
        movieTitleLabel.textAlignment = .center
        movieTitleLabel.lineBreakMode = .byWordWrapping
        movieTitleLabel.numberOfLines = 0
        return movieTitleLabel
    }()
    
    lazy var movieYearLabel: UILabel = {
        var teamMemberTitleLabel = UILabel()
        teamMemberTitleLabel.sizeToFit()
        teamMemberTitleLabel.font = UIFont(name: "HelveticaNeue-Light", size: 16)
        return teamMemberTitleLabel
    }()
    
    lazy var movieCastLabel: UITextView = {
        var teamMemberBioText = UITextView()
        teamMemberBioText.sizeToFit()
        teamMemberBioText.font = UIFont(name: "HelveticaNeue-Light", size: 11)
        teamMemberBioText.textAlignment = .center
        teamMemberBioText.backgroundColor = UIColor.clear
        teamMemberBioText.isScrollEnabled = true
        teamMemberBioText.isEditable = false
        return teamMemberBioText
    }()
}

extension MovieCell {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        isUserInteractionEnabled = true
        backgroundColor = UIColor.white
        self.contentView.layer.cornerRadius = 2.0
        self.contentView.layer.borderWidth = 1.0
        self.contentView.layer.borderColor = UIColor.clear.cgColor
        self.contentView.layer.masksToBounds = true;
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOffset = CGSize(width:0,height: 2.0)
        self.layer.shadowRadius = 1.0
        self.layer.shadowOpacity = 0.5
        self.layer.masksToBounds = false;
        self.layer.shadowPath = UIBezierPath(roundedRect:self.bounds, cornerRadius:self.contentView.layer.cornerRadius).cgPath
    }
}

extension MovieCell {
    
    func configureCell(movie: Movie) {
        layoutSubviews()
        setupConstraints()
        layoutIfNeeded()
        movieCastLabel.isHidden = true
        posterView.layer.cornerRadius =  posterView.frame.height / 2.0
        client.downloadImage(url: URL(string:movie.posterURL)!) { [unowned self] image in
            DispatchQueue.main.async { 
                self.posterView.image = image
                self.movieYearLabel.text = movie.year
                self.movieTitleLabel.text = "\(movie.title)"
                self.movieCastLabel.text = movie.director
            }
        }
    }
    
    func setupConstraints() {
        contentView.addSubview(movieTitleLabel)
        movieTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        movieTitleLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.48).isActive = true
        movieTitleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor, constant: contentView.bounds.width * 0.21).isActive = true
        movieTitleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: contentView.bounds.height * -0.12).isActive = true
        
        contentView.addSubview(posterView)
        posterView.translatesAutoresizingMaskIntoConstraints = false
        posterView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: contentView.bounds.height * 0.1).isActive = true
        posterView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        posterView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.386).isActive = true
        posterView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.8).isActive = true
        
        contentView.addSubview(movieYearLabel)
        movieYearLabel.translatesAutoresizingMaskIntoConstraints = false
        movieYearLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor, constant: contentView.bounds.width * 0.2).isActive = true
        movieYearLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: UIScreen.main.bounds.height * -0.08).isActive = true
        
        contentView.addSubview(movieCastLabel)
        movieCastLabel.translatesAutoresizingMaskIntoConstraints = false
        movieCastLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        movieCastLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.35).isActive = true
        movieCastLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.5).isActive = true
        movieCastLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: contentView.bounds.height * -0.05).isActive = true
    }
}
