//
//  APITests.swift
//  Video Club AppTests
//
//  Created by Rodrigo Camargo on 5/16/21.
//

import XCTest
@testable import Video_Club_App

class APITests: XCTestCase {

    func test_Api_Movies_ReturnsNotNil(){
        var movieManager = MovieManager()
        movieManager.getMovies { (result,error) in
            XCTAssertNotNil(result)
            XCTAssertNil(error)
        }
    }
    
    func test_Api_Genres_ReturnsNotNil(){
        var genreManager = GenreManager()
        genreManager.getGenres { (result,error) in
            XCTAssertNotNil(result)
            XCTAssertNil(error)
        }
    }
    
    func test_Api_MovieReviews_ReturnsNotNil(){
        var reviewManager = ReviewManager()
        reviewManager.getReviews("460465"){ (result,error) in
            XCTAssertNotNil(result)
            XCTAssertNil(error)
        }
    }
    
    func test_Api_MovieReviews_ReturnsNil(){
        var reviewManager = ReviewManager()
        reviewManager.getReviews("1"){ (result,error) in
            XCTAssertNil(result)
            XCTAssertNotNil(error)
        }
    }

}
