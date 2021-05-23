//
//  RealmTests.swift
//  Video Club AppTests
//
//  Created by Rodrigo Camargo on 5/16/21.
//

import XCTest
@testable import Video_Club_App

class RealmTests: XCTestCase {
    
    override class func setUp() {
        let movieModel = MovieModel()
        let genreModel = GenreModel()
        let reviewModel = ReviewModel()

        movieModel.fetchMovies {
            
        }
        genreModel.fetchGenres()
        reviewModel.fetchReviews("460465", "1")
    }

    func test_GetMovieFromRealm_ReturnsMovie() {
        let realmDB = RealmDatabase()
        let movieSelected = realmDB.getMovie(1)

        XCTAssertNotNil(movieSelected)
        XCTAssertTrue(movieSelected.id != "")
        XCTAssertTrue(movieSelected.title != "")
    }
    
    func test_GetGenreFromRealm_ReturnsGenre() {
        let realmDB = RealmDatabase()
        let genreSelected = realmDB.getGenre(28)

        XCTAssertNotNil(genreSelected)
        XCTAssertEqual("Action", genreSelected.name)
    }
    
    func test_GetReviewFromRealm_ReturnsReview() {
        let realmDB = RealmDatabase()
        let reviews = realmDB.getReviews(1)
        XCTAssertTrue(reviews.count > 0)
        XCTAssertNotNil(reviews)
    }
    
    func test_LastConnection_ReturnsDate() {
        let realmDB = RealmDatabase()
        let dateData = DateData()
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy HH:mm"
        
        let result = realmDB.getLastConnecionDate()
        
        let currentDate = dateData.dateToString(date)
        let lastConnectionDate = dateData.dateToString(result)
        
        let formattedCurrentDate = formatter.date(from: currentDate)
        let formattedCurrentDateString = dateData.dateToString(formattedCurrentDate!)
        
        XCTAssertNotNil(result)
        XCTAssertTrue(lastConnectionDate != "")
        XCTAssertTrue(formattedCurrentDateString != "")
        XCTAssertEqual(formattedCurrentDateString, lastConnectionDate)
    }

}
