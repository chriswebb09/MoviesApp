//
//  DetailView.swift
//  MoviesApp
//
//  Created by Christopher Webb-Orenstein on 12/30/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

struct DatailViewModel {
    var posterImage: UIImage
    var nameLabel: String
}

class DetailView: UIView {
    
    // MARK - Setup UI Elements
    
    var client = APIClient()
    
    var posterImage: UIImageView = {
        var posterImage = UIImageView()
        posterImage.layer.borderWidth = 2
        posterImage.clipsToBounds = true
        return posterImage
    }()
    
    var teamMemberNameLabel: UILabel = {
        var teamMemberNameLabel = UILabel()
        teamMemberNameLabel.textAlignment = .center
        teamMemberNameLabel.lineBreakMode = .byWordWrapping
        teamMemberNameLabel.numberOfLines = 0
        teamMemberNameLabel.sizeToFit()
        teamMemberNameLabel.font = Constants.Font.bolderFontLarge
        return teamMemberNameLabel
    }()
    
    var teamMemberTitleLabel: UILabel = {
        var teamMemberTitleLabel = UILabel()
        teamMemberTitleLabel.sizeToFit()
        teamMemberTitleLabel.textAlignment = .center
        teamMemberTitleLabel.font = Constants.Font.thinFontLarge
        return teamMemberTitleLabel
    }()
    
    var bioTextView: UITextView = {
        var teamMemberBioText = UITextView()
        teamMemberBioText.sizeToFit()
        teamMemberBioText.font = Constants.Font.fontSmall
        teamMemberBioText.textAlignment = .center
        teamMemberBioText.isScrollEnabled = true
        return teamMemberBioText
    }()
    
    let doneButton: UIButton = {
        var button = ButtonType.system(title: "Done", color: UIColor.white)
        var uiButton = button.newButton
        uiButton.layer.cornerRadius = 0
        uiButton.backgroundColor = Constants.Color.buttonColorBlue
        return uiButton
    }()
    
}

extension DetailView {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.borderWidth = 1
        isUserInteractionEnabled = true
        backgroundColor = UIColor.white
        layer.cornerRadius = 2.0
        layer.borderWidth = 1.0
        layer.borderColor = UIColor.clear.cgColor
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOffset = CGSize(width:0,height: 2.0)
        layer.shadowRadius = 1.0
        layer.shadowOpacity = 0.5
        layer.masksToBounds = true
        layer.shadowPath = UIBezierPath(roundedRect:bounds, cornerRadius:layer.cornerRadius).cgPath
    }
    
    // MARK: - Configure View
    
    func configureView(movie: Movie) {
        
        client.downloadImage(url: URL(string:movie.posterURL)!, handler: { image in
            DispatchQueue.main.async {
                self.teamMemberNameLabel.text = "\(movie.title)"
                self.bioTextView.text = movie.director
                self.posterImage.image = image
            }
        })
        posterImage.layer.cornerRadius = posterImage.frame.height / 4
        layoutSubviews()
        setupConstraints()
        teamMemberTitleLabel.text = "\(movie.director)"
    }
    
    // MARK: - Configure constraints
    
    func setupConstraints() {
        addSubview(teamMemberNameLabel)
        teamMemberNameLabel.translatesAutoresizingMaskIntoConstraints = false
        teamMemberNameLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        teamMemberNameLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8).isActive = true 
        teamMemberNameLabel.topAnchor.constraint(equalTo: topAnchor, constant:20).isActive = true
        
        addSubview(posterImage)
        posterImage.translatesAutoresizingMaskIntoConstraints = false
        posterImage.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        posterImage.topAnchor.constraint(equalTo: teamMemberNameLabel.bottomAnchor, constant: 50).isActive = true
        posterImage.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.35).isActive = true
        posterImage.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.26).isActive = true
        
        addSubview(teamMemberTitleLabel)
        teamMemberTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        teamMemberTitleLabel.centerXAnchor.constraint(equalTo: posterImage.centerXAnchor).isActive = true
        teamMemberTitleLabel.topAnchor.constraint(equalTo: topAnchor, constant:50).isActive = true
        
        addSubview(bioTextView)
        bioTextView.translatesAutoresizingMaskIntoConstraints = false
        bioTextView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        bioTextView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.38).isActive = true
        bioTextView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.89).isActive = true
        
        addSubview(doneButton)
        doneButton.translatesAutoresizingMaskIntoConstraints = false
        doneButton.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        doneButton.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        doneButton.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.14).isActive = true
        doneButton.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        bioTextView.bottomAnchor.constraint(equalTo: doneButton.topAnchor).isActive = true
    }
}
