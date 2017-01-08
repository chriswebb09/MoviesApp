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

final class DetailView: UIView {
    
    // MARK - Setup UI Elements
    
    fileprivate var client = APIClient()
    
    deinit {
        print("detailview deallocated")
    }
    
    lazy var posterImage: UIImageView = {
        var posterImage = UIImageView()
        posterImage.layer.borderWidth = 2
        posterImage.clipsToBounds = true
        return posterImage
    }()
    
    lazy var movieTitleLabel: UILabel = {
        var movieTitleLabel = UILabel()
        movieTitleLabel.textAlignment = .center
        movieTitleLabel.lineBreakMode = .byWordWrapping
        movieTitleLabel.numberOfLines = 0
        movieTitleLabel.sizeToFit()
        movieTitleLabel.font = Constants.Font.bolderFontMediumLarge
        return movieTitleLabel
    }()
    
    lazy var movieYearLabel: UILabel = {
        var movieYearLabel = UILabel()
        movieYearLabel.sizeToFit()
        movieYearLabel.textAlignment = .center
        movieYearLabel.font = Constants.Font.thinFontMedium
        return movieYearLabel
    }()
    
    lazy var plotTextView: UITextView = {
        var plotTextView = UITextView()
        plotTextView.sizeToFit()
        plotTextView.font = Constants.Font.thinFontSmall
        plotTextView.textAlignment = .justified
        plotTextView.isEditable = false
        plotTextView.isScrollEnabled = true
        return plotTextView
    }()
    
    lazy var doneButton: UIButton = {
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
        layoutSubviews()
        setupConstraints()
        client.downloadImage(url: URL(string:movie.posterURL)!, handler: { [unowned self] image in
            DispatchQueue.main.async { [unowned self] in
                self.layoutIfNeeded()
                self.movieTitleLabel.text = "\(movie.title)"
                self.movieYearLabel.text = "\(movie.year)"
                self.plotTextView.text = "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur?"
                self.posterImage.image = image
                self.posterImage.layer.cornerRadius = self.posterImage.frame.height / 4
            }
        })
        
    }
    
    // MARK: - Configure constraints
    
    fileprivate func setupConstraints() {
        addSubview(movieTitleLabel)
        movieTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        movieTitleLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        movieTitleLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8).isActive = true
        movieTitleLabel.topAnchor.constraint(equalTo: topAnchor, constant: UIScreen.main.bounds.height * 0.028).isActive = true
        
        
        addSubview(movieYearLabel)
        movieYearLabel.translatesAutoresizingMaskIntoConstraints = false
        movieYearLabel.centerXAnchor.constraint(equalTo: movieTitleLabel.centerXAnchor).isActive = true
        movieYearLabel.topAnchor.constraint(equalTo: movieTitleLabel.bottomAnchor, constant: UIScreen.main.bounds.height * 0.02).isActive = true
        
        addSubview(posterImage)
        posterImage.translatesAutoresizingMaskIntoConstraints = false
        posterImage.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        posterImage.topAnchor.constraint(equalTo: movieYearLabel.bottomAnchor, constant: UIScreen.main.bounds.height * 0.025).isActive = true
        posterImage.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.4).isActive = true
        posterImage.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.28).isActive = true
        
        addSubview(plotTextView)
        plotTextView.translatesAutoresizingMaskIntoConstraints = false
        plotTextView.topAnchor.constraint(equalTo: posterImage.bottomAnchor, constant: UIScreen.main.bounds.height * 0.01).isActive = true
        plotTextView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        plotTextView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.33).isActive = true
        plotTextView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.94).isActive = true
        
        addSubview(doneButton)
        doneButton.translatesAutoresizingMaskIntoConstraints = false
        doneButton.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        doneButton.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        doneButton.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.14).isActive = true
        doneButton.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
    }
}
