//
//  GenreModel.swift
//  Video Club App
//
//  Created by Rodrigo Camargo on 4/26/21.
//

import Foundation
import RealmSwift

struct GenreInfo: Codable {
    let id: Int
    let name: String
}

struct GenreData: Codable {
    var genres: [GenreInfo]
    
}

class Genre: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
}
