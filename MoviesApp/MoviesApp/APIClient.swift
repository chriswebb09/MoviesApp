//
//  APIClient.swift
//  MoviesApp
//
//  Created by Christopher Webb-Orenstein on 12/30/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit
typealias JSONData = [String : Any]

class APIClient {
    let store = DataStore.sharedInstance
    var queue = OperationQueue()
    static let sharedInstance = APIClient()
    var movies = [Movie]()
    let session = URLSession(configuration: URLSessionConfiguration.default)
}

extension APIClient {
    
    func getDataFromUrl(url: URL, completion: @escaping (_ data: Data?, _  response: URLResponse?, _ error: Error?) -> Void) {
        let urlRequest = URLRequest(url:url)
        session.dataTask(with: urlRequest, completionHandler: { data, response, error in
            completion(data, response, error)
        }).resume()
    }
    
    func downloadImage(url: URL, handler: @escaping (UIImage) -> Void) {
        print("Download Started")
        getDataFromUrl(url: url) { data, response, error in
            let op1 = BlockOperation(block: {
                guard let data = data, error == nil else { return }
                OperationQueue.main.addOperation({ handler(UIImage(data: data)!) })
            })
            op1.completionBlock = {
                print("Op1 finished")
            }
            self.queue.addOperation(op1)
        }
    }
}

extension APIClient {
    
    func sendAPICall(fromUrlString:String, completion: @escaping ([Movie]) -> Void) {
        let url = URL(string: fromUrlString)!
        getDataFromUrl(url: url, completion: { data, response, error in
            guard let data = data else { return }
            do {
                let result = try? JSONSerialization.jsonObject(with: data, options:[]) as! [String:AnyObject]
                let dataResponse = result?["Search"] as AnyObject
                let searchData = dataResponse as! [[String:String]]
                searchData.forEach { finalData in
                    guard let title = finalData["Title"] else { return }
                    guard let imdbID = finalData["imdbID"] else { return }
                    guard let genre = finalData["Type"] else { return }
                    guard let posterURL = finalData["Poster"] else { return }
                    let movie = Movie(title: title, year: "None", director: "None", cast: ["NONE"], genre: [genre], imdbID: imdbID, posterURL: posterURL)
                    self.movies.append(movie)
                }
                completion(self.movies)
            }
        })
    }
}
