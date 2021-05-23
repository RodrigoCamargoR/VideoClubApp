//
//  Video_Club_AppTests.swift
//  Video Club AppTests
//
//  Created by Rodrigo Camargo on 4/21/21.
//

import XCTest
@testable import Video_Club_App

class ReviewModelTests: XCTestCase {

    func test_format_path () {
        let reviewModel = ReviewModel()
        let path = "http://www.something.com/this/is/an/img.png"
        let result = reviewModel.formatAvatarPath(path)
        XCTAssertEqual(result, "img.png")
    }
}
