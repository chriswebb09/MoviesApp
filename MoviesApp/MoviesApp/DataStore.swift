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
}
