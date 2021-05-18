//
//  MovieModelTests.swift
//  Video Club AppTests
//
//  Created by Rodrigo Camargo on 5/16/21.
//

import XCTest
@testable import Video_Club_App

class MovieModelTests: XCTestCase {

    func test_GetStarsAmount_ReturnsInt(){
        let movieModel = MovieModel()
        let stars = movieModel.getStarsAmount(8.0)
        
        XCTAssertEqual(stars, 4)
    }
    
    func test_GetStarsAmount_ProvideNumberBiggerThan10(){
        let movieModel = MovieModel()
        let stars = movieModel.getStarsAmount(10.1)
        
        XCTAssertEqual(stars, 5)
    }
    
    func test_GetStarsAmount_ProvideNegativeNumber(){
        let movieModel = MovieModel()
        let stars = movieModel.getStarsAmount(-1.1)
        
        XCTAssertEqual(stars, 0)
    }

}
