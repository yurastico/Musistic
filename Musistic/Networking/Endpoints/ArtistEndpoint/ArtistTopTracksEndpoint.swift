//
//  ArtistTopTracks.swift
//  Musistic
//
//  Created by Yuri Cunha on 28/01/24.
//

import Foundation

struct ArtistTopTracksEndpoint: Endpoint {
    let artistId: String
    let accessToken: String
    var host: String {
        SpotifyBaseURL.api.rawValue
    }
    
    var path: String {
        "/v1/artists/top-tracks"
    }
    
    var method: RequestMethod {
        .get
    }
    
    var header: [String : String]? {
        ["Authorization": "Bearer \(accessToken)"]
    }
    
    var jsonBody: [String : String]?
    
    var queryItems: [URLQueryItem]?
    
    
}
