//
//  GenreModel.swift
//  Video Club App
//
//  Created by Rodrigo Camargo on 5/3/21.
//

import Foundation

class GenreModel {
    private var genreManager = GenreManager()
    private var realm = RealmDatabase()
    var genres = [GenreInfo]()
    
    func fetchGenres() {
        genreManager.getGenres { (listOf, error) in
            if error == nil {
                self.genres = listOf!.genres
                // Save to genres to database
                for genre in self.genres {
                    self.realm.saveGenre(genre)
                }
            } else {
                print("There was an error when processing Json data: \(error!)")
            }
        }
    }

}
