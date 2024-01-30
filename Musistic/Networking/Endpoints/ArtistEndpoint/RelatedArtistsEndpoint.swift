//
//  RelatedArtistsEndpoint.swift
//  Musistic
//
//  Created by Yuri Cunha on 28/01/24.
//

import Foundation

struct RelatedArtistsEndpoint: Endpoint {
    let artistId: String
    let accessToken: String
    var host: String {
        SpotifyBaseURL.api.rawValue
    }
    
    var path: String {
        "/v1/artists/\(artistId)/related-artists"
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
                        