//
//  MovieModel.swift
//  Video Club App
//
//  Created by Rodrigo Camargo on 4/21/21.
//

import UIKit
import RealmSwift

class MovieModel {
    private var movieManager = MovieManager()
    private var realmDB = RealmDatabase()
    let realm = try! Realm()
    var moviesRealm: Results<Movie>?
    var movies = [MovieInfo]()
    
    func fetchMovies(completion: @escaping () -> ()) {
        movieManager.getMovies { (listOf, error) in
            if error == nil {
                self.movies = listOf!.movies
                // Save to movies to database
                var index = 0
                for movie in self.movies{
                    self.realmDB.saveMovie(movie, index)
                    index += 1
                }
                self.loadMoviesFromRealm()
                completion()
            }else{
                print("There was an error when processing Json data: \(error!)")
            }
        }
    }
    
    func loadMoviesFromRealm(){
        moviesRealm = realm.objects(Movie.self)
    }
    
    func numberOfRows(section: Int) -> Int {
        if moviesRealm?.count != nil {
            return moviesRealm!.count
        }else{
            return 0
        }
    }
    
    func cellForRowAt(indexPath: IndexPath) -> Movie {
        let currentMovie = moviesRealm![indexPath.row]
        return currentMovie
    }
    
    func getStarsAmount(_ rate: Double) -> Int{
        let rating = (rate*5)/10
        switch true {
        case rating > 4.5:
            return 5
        case rating > 3.6:
            return 4
        case rating > 2.6:
            return 3
        case rating > 1.6:
            return 2
        case rating > 0.6:
            return 1
        default:
            return 0
        }
    }
    
}
