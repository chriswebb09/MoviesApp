//
//  FavMovie.swift
//  MoviesApp
//
//  Created by Christopher Webb-Orenstein on 1/3/17.
//  Copyright © 2017 Christopher Webb-Orenstein. All rights reserved.
//

import Foundation
import RealmSwift

class FavMovie: Object {
    dynamic var title = ""
    dynamic var director = ""
    dynamic var cast = [String]()
    dynamic var year = ""
    dynamic var imdbID = ""
    
    
// Specify properties to ignore (Realm won't persist these)
    
//  override static func ignoredProperties() -> [String] {
//    return []
//  }
}
