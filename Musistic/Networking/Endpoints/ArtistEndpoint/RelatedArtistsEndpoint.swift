//
//  RelatedArtistsEndpoint.swift
//  Musistic
//
//  Created by Yuri Cunha on 28/01/24.
//

import Foundation

enum RelatedArtistsEndpoint: Endpoint {
    case relatedArtists(String)
    case details(String)
    var host: String {
        SpotifyBaseURL.api.rawValue
    }
    
    var path: String {
        switch self {
        case .relatedArtists(let artistId):
            return "/v1/artists/\(artistId)/related-artists"
        case .details(let artistId):
            return "/v1/artists/\(artistId)"
        }
        
    }
    
    var method: RequestMethod {
        .get
    }
    
    var header: [String : String]? {
        ["Authorization": "Bearer \(SpotifyAuthenticationManager.shared.accessToken ?? "")"]
    }
    
    var jsonBody: [String : String]?
    
    var queryItems: [URLQueryItem]?
}
                        
