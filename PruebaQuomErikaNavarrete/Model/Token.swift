//
//  Token.swift
//  PruebaQuomErikaNavarrete
//
//  Created by MacBookMBA1 on 12/07/23.
//

import Foundation
struct Token : Codable {
    private var ts : Int = 1
    private var apikey : String = "68206b92a1320a46c9590ca64c6e21b0"
    private var hash : String = "70cca781ba55d78eabb025b818a073c9"
    
    static let shared = Token()
    
    private init() {}
    
    func GetTs() -> Int{
        return ts
    }
    
    func GetApiKey() -> String {
        return apikey
    }
    
    func GetHash() -> String {
        return hash
    }
}
