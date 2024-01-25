//
//  ArtistAlbunsEndpoint.swift
//  Musistic
//
//  Created by Yuri Cunha on 25/01/24.
//

import Foundation

struct ArtistAlbunsEndpoint: Endpoint {
    let artistId: String
    var host: String {
        SpotifyBaseURL.api.rawValue
    }
    
    var path: String {
        "/artist/\(artistId)/albuns"
    }
    
    var method: RequestMethod {
        .get
    }
    
    var header: [String : String]?
    
    var jsonBody: [String : String]?
    
    var queryItems: [URLQueryItem]?
}
