//
//  GenreModel.swift
//  Video Club App
//
//  Created by Rodrigo Camargo on 4/26/21.
//

import Foundation
import RealmSwift

class GenreInfo: Codable {
    let id: Int
    let name: String
}

class GenreData: Codable {
    var genres: [GenreInfo]
    
}

class Genre: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
}
