//
//  ReviewManager.swift
//  Video Club App
//
//  Created by Rodrigo Camargo on 5/17/21.
//

import Foundation

struct ReviewManager {
    
    var api = MoviesApi()

    mutating func getReviews(_ id: String, completion: @escaping (ReviewData?, Error?) -> ()){
        api.getReviews(id) { (result) in
            switch result {
            case .success(let listOf):
                completion(listOf, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
}
