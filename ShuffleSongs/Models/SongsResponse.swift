//
//  SongsResponse.swift
//  ShuffleSongs
//
//  Created by Rodrigo Kieffer on 24/07/19.
//  Copyright © 2019 Rodrigo Kieffer. All rights reserved.
//

import Foundation

struct SongsResponse: Codable {
    var resultCount: Int?
    var results: [Result]
}

struct Result: Codable {
    var wrapperType: String?
    
    var artistType: String?
    var primaryGenreName: String?
    var artistName: String?
    var id: Int?
    
    var trackExplicitness: String?
    var trackCensoredName: String?
    var collectionId: Int?
    var trackName: String?
    var country: String?
    var artworkUrl: String?
    var releaseDate: String?
    var artistId: Int?
    var trackTimeMillis: Int?
    var collectionName: String?
}
