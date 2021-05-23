//
//  MovieManager.swift
//  Video Club App
//
//  Created by Rodrigo Camargo on 4/21/21.
//

import UIKit

struct MovieManager {    
    var api = MoviesApi()

    mutating func getMovies(completion: @escaping (MovieData?, Error?) -> Void) {
        api.getMovies() { (result) in
            switch result {
            case .success(let listOf):
                completion(listOf, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
}
