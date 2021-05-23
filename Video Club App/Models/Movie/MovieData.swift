//
//  MovieData.swift
//  Video Club App
//
//  Created by Rodrigo Camargo on 4/21/21.
//

import Foundation
import RealmSwift

class MovieData: Codable {
    let movies: [MovieInfo]
    
    private enum CodingKeys: String, CodingKey {
        case movies = "results"
    }
}

class MovieInfo: Codable {
    let id: Int
    let title: String
    let overview: String
    let posterImage: String
    let year: String
    let rate: Double
    let popularity: Double
    let secondImg: String
    let genres: [Int]
    
    private enum CodingKeys: String, CodingKey {
        case title, overview, id, popularity
        case year = "release_date"
        case rate = "vote_average"
        case posterImage = "poster_path"
        case secondImg = "backdrop_path"
        case genres = "genre_ids"
    }
}

class Movie: Object {
    @objc dynamic var id: String = ""
    @objc dynamic var dbId: Int = 0
    @objc dynamic var title: String = ""
    @objc dynamic var overview: String = ""
    @objc dynamic var posterImage: String = ""
    @objc dynamic var year: String = ""
    @objc dynamic var rate: Double = 0.0
    @objc dynamic var popularity: Double = 0
    @objc dynamic var secondImg: String = ""
    let genres = List<Int>()
    var reviews = List<Review>()
    
    func hasReviews(_ reveiew: Int) -> Bool {
        return reveiew > 0 ? true : false
    }
}
