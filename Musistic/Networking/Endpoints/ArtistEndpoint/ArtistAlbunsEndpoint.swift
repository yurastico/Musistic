//
//  ArtistAlbunsEndpoint.swift
//  Musistic
//
//  Created by Yuri Cunha on 25/01/24.
//

import Foundation

struct ArtistAlbunsEndpoint: Endpoint {
    let artistId: String
    let accessToken: String
    var host: String {
        SpotifyBaseURL.api.rawValue
    }
    
    var path: String {
        "/v1/artists/\(artistId)/albums"
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
