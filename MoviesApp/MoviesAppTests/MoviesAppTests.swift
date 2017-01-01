//
//  MoviesAppTests.swift
//  MoviesAppTests
//
//  Created by Christopher Webb-Orenstein on 12/30/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import XCTest
@testable import MoviesApp

class MoviesAppTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testMovieItem() {
        let exampleMovie = Movie(title: "ExampleMovie", year: "1990", director: "Example Director", cast: ["Example Castmember"], genre: ["Example Fiction"], imdbID: "exampleImdbID", posterURL: "http://example.con")
        XCTAssertEqual(exampleMovie.title, "ExampleMovie", "Title for example movie item should be ExampleMoview")
    }
    
    func testDataStore() {
        let store = DataStore.sharedInstance
        let exampleMovie = Movie(title: "ExampleMovie", year: "1990", director: "Example Director", cast: ["Example Castmember"], genre: ["Example Fiction"], imdbID: "exampleImdbID", posterURL: "http://example.con")
        store.movies = [exampleMovie]
        XCTAssertEqual(store.movies.count, 1, "There should be one movie in DataStore movies array")
    }
    
    
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
