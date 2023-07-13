//
//  Root.swift
//  PruebaQuomErikaNavarrete
//
//  Created by MacBookMBA1 on 12/07/23.
//

import Foundation
struct Root : Codable {
    var data : Results?
    
    init() {
        self.data = nil
    }
}

struct Results : Codable{
    var results : [Comics]
}

struct Comics : Codable {
    var id : Int
    var title : String
    var thumbnail : Thumbnail
    var creators : Creators
    var textObjects : [TextObjects]
}

struct TextObjects : Codable{
    var text : String
}

struct Thumbnail : Codable {
    var path : String
    var extention : String
    
    enum CodingKeys : String, CodingKey{
        case path
        case extention = "extension"
    }
    
}

struct Creators : Codable {
    var items : [Items]
    
    init(){
        self.items = []
    }
}

struct Items : Codable {
    var name : String
    var role : String
}

