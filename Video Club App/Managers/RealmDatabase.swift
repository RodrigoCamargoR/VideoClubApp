//
//  RealmDatabase.swift
//  Video Club App
//
//  Created by Rodrigo Camargo on 5/4/21.
//

import Foundation
import RealmSwift

struct RealmDatabase {
    
    let realm = try! Realm()
    
    // MARK: - Add current DateTime connection to Realm
    
    func addCurrentConnectionDateTime() {
        let date = Date()
        let d: DateData = DateData()
        let dateString: String = d.dateToString(date)
        d.date = dateString
        // Update last connection with the new one
        try! realm.write {
            try! realm.delete(Realm().objects(DateData.self))
            realm.add(d)
        }
    }
    
    func isEmpty() -> Bool {
        return realm.isEmpty
    }
    
    // MARK: - Get last connection DateTime
    func getLastConnecionDate() -> Date {
        var newLastDate = Date()
        let lastDate = realm.objects(DateData.self)
        newLastDate = DateData().stringToDate(lastDate[0].date)
        
        return newLastDate
    }
    
    // MARK: - Delete all data from Realm

    func deleteAllData() {
        try! realm.write {
            try! realm.delete(Realm().objects(Movie.self))
            try! realm.delete(Realm().objects(Genre.self))
            try! realm.delete(Realm().objects(Review.self))
        }
    }
    
    // MARK: - Movies
    func saveMovie(_ movie: MovieInfo, _ index: Int) {
        let mov: Movie = formatMovieClass(movie, index)
        do {
            try realm.write {
                realm.add(mov)
            }
        } catch {
            print("There was an error when adding the movie to the realm: \(error)")
        }
    }
    
    func getMovie(_ movieID: Int) -> Movie {
        var movieSelected = Movie()
        let movies = realm.objects(Movie.self)
        for movie in movies where movie.dbId == movieID {
            movieSelected = movie
        }
        return movieSelected
    }
    
    func formatMovieClass(_ movie: MovieInfo, _ index: Int) -> Movie {
        let newMovie = Movie()
        newMovie.id = String(movie.id)
        newMovie.dbId = index
        newMovie.title = movie.title
        newMovie.year = movie.year
        newMovie.overview = movie.overview
        newMovie.popularity = movie.popularity
        newMovie.rate = movie.rate
        newMovie.posterImage = movie.posterImage
        newMovie.secondImg = movie.secondImg
        for genre in movie.genres {
            newMovie.genres.append(genre)
        }
        
        return newMovie
    }
    
    // MARK: - Genres
    
    func saveGenre(_ genre: GenreInfo) {
        let gen: Genre = formatToGenre(genre)
        do {
            try realm.write {
                realm.add(gen)
            }
        } catch {
            print("There was an error when adding the genre to the realm: \(error)")
        }
    }
    
    func getGenre(_ genreId: Int) -> Genre {
        let newGenre = Genre()
        let genres = realm.objects(Genre.self)
        for genre in genres where genre.id == genreId {
            newGenre.id = genre.id
            newGenre.name = genre.name
        }
        return newGenre
    }
    
    func formatToGenre(_ genre: GenreInfo) -> Genre {
        let newGenre = Genre()
        newGenre.id = genre.id
        newGenre.name = genre.name
        return newGenre
    }
    
    // MARK: - Reviews
    
    func saveReview(_ review: ReviewInfo, _ movieId: String) {
        let rev: Review = formatToReview(review)
        let selectedMovie = getMovie(Int(movieId)!)
        do {
            try realm.write {
                selectedMovie.reviews.append(rev)
            }
        } catch {
            print("There was an error when adding the review to the realm: \(error)")
        }
    }
    
    func getReviews(_ movieId: Int) -> [Review] {
        var reviews = [Review]()
        let movieSelected = getMovie(movieId)
        for review in movieSelected.reviews {
            reviews.append(review)
        }

        return reviews
    }
    
    func deleteReviewsFromMovie(_ movie: String) {
        let allMovies = realm.objects(Movie.self)
        for mov in allMovies {
            if mov.dbId == Int(movie) {
                do {
                    try realm.write {
                        realm.delete(mov.reviews)
                    }
                } catch {
                    print("Error removing the reviews: \(error)")
                }
            }
        }
    }
    
    func formatToReview(_ review: ReviewInfo) -> Review {
        let reviewModel = ReviewModel()
        let newReview = Review()
        newReview.id = review.id
        newReview.content = review.content
        newReview.authorUser = review.author.user
        var avatarImg = "Na"
        guard let path = review.author.avatar else { return newReview }
        avatarImg = reviewModel.formatAvatarPath(path)
        newReview.authorAvatar = avatarImg
        return newReview
    }
}
