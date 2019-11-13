//
//  Profile.swift
//  OkCupidDemo
//
//  Created by Paul McGrath on 11/11/19.
//  Copyright © 2019 Paul McGrath. All rights reserved.
//

import Foundation

struct Location: Codable {
    var cityName: String
    var countryCode: String
    var countryName: String
    var stateCode: String
    var stateName: String
    
    enum CodingKeys: String, CodingKey {
        case cityName = "city_name"
        case countryCode = "country_code"
        case countryName = "country_name"
        case stateCode = "state_code"
        case stateName = "state_name"
    }
}

struct ProfileImage: Codable {
    var large: String
    var medium: String
    var original: String
    var small: String
}

struct APIResponse: Codable {
    var data: [Profile]
    var paging: Paging
    var total_matches: Int
}

struct Paging: Codable {
    var cursors: Cursors
}

struct Cursors: Codable {
    var after: String
    var before: String
    var current: String
}

struct Profile: Codable {
    var age: Int
    var isOnline: Int
    var liked: Bool
    var location: Location
    var match: Int
    var photo: ProfileImage
    var userId: String
    var userName: String
    
    enum CodingKeys: String, CodingKey {
        case age
        case isOnline = "is_online"
        case liked
        case location
        case match
        case photo
        case userId = "userid"
        case userName = "username"
    }
    
}
