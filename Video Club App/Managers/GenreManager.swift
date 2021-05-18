//
//  GenreManager.swift
//  Video Club App
//
//  Created by Rodrigo Camargo on 5/17/21.
//

import Foundation

struct GenreManager {
    var api = MoviesApi()
    
    mutating func getGenres(completion: @escaping (GenreData?, Error?) -> ()){
        api.getMovieGenres() { (result) in
            switch result {
            case .success(let listOf):
                completion(listOf, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
}
