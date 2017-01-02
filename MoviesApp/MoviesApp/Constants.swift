//
//  Constants.swift
//  MoviesApp
//
//  Created by Christopher Webb-Orenstein on 12/30/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

struct Constants {
    struct Font {
        static let fontNormal = UIFont(name: "HelveticaNeue-Light", size: 18)
        static let fontExtraSmall = UIFont(name: "HelveticaNeue-Light", size: 12)
        static let fontSmall = UIFont(name: "HelveticaNeue-Light", size: 14)
        static let fontMedium = UIFont(name: "HelveticaNeue-Light", size: 16)
        static let fontLarge = UIFont(name: "HelveticaNeue-Thin", size: 22)
        static let thinFontLarge = UIFont(name: "HelveticaNeue-Thin", size: 18)
        static let thinFontMedium = UIFont(name: "HelveticaNeue-Thin", size: 16)
        static let bolderFontSmall = UIFont(name: "HelveticaNeue", size: 12)
        static let bolderFontMedium = UIFont(name: "HelveticaNeue", size: 16)
        static let bolderFontLarge = UIFont(name: "HelveticaNeue", size: 22)
        static let bolderFontNormal = UIFont(name: "HelveticaNeue", size: 18)
    }
    
    struct Color {
        static let buttonColorBlue = UIColor(red:0.41, green:0.72, blue:0.90, alpha:1.0)
    }
    
    static let signupFieldFont = UIFont(name: "HelveticaNeue-Thin" , size: 16)
    static let borderWidth:CGFloat = 1
    static let searchFieldButtonRadius: CGFloat = 2
    static let signupFieldColor = UIColor.lightGray.cgColor
    static let mainOffset:CGFloat = 30
    static let centerYOffset:CGFloat = 0.1
    static let buttonColor = UIColor(red:0.10, green:0.71, blue:1.00, alpha:1.0)
    static let friendsHeaderLabelHeight:CGFloat = 0.85
    static let friendsHeaderLabelTopOffset:CGFloat = 0.2
    static let buttonHeight = CGFloat(0.07)
}


