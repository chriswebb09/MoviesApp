//
//  DataStore.swift
//  MoviesApp
//
//  Created by Christopher Webb-Orenstein on 12/30/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

class DataStore {
    static let sharedInstance = DataStore()
    var movies = [Movie]()
    var searchTerm: String = ""
    var movieURL: String = "http://www.omdbapi.com/?i=tt1403981&plot=short&r=json"
    var numberOfResults = 0 
}
