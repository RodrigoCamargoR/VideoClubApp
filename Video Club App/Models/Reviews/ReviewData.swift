//
//  ReviewModel.swift
//  Video Club App
//
//  Created by Rodrigo Camargo on 4/28/21.
//

import Foundation
import RealmSwift

struct ReviewData: Codable {
    let reviews: [ReviewInfo]
    
    private enum CodingKeys: String, CodingKey{
        case reviews = "results"
    }
}

struct ReviewInfo: Codable {
    let id: String
    let content: String
    let author: ReviewAuthor
    
    private enum CodingKeys: String, CodingKey{
        case content, id
        case author = "author_details"
    }
}

struct ReviewAuthor: Codable {
    let user: String
    let name: String?
    let avatar: String?
    
    private enum CodingKeys: String, CodingKey{
        case name
        case user = "username"
        case avatar = "avatar_path"
    }
}

class Review: Object {
    @objc dynamic var id: String = ""
    @objc dynamic var content : String = ""
    @objc dynamic var authorUser : String = ""
    @objc dynamic var authorAvatar : String = ""
    
    var parentMovie = LinkingObjects(fromType: Movie.self, property: "reviews")
}
