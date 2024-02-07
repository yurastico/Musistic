//
//  RelatedArtistsEndpoint.swift
//  Musistic
//
//  Created by Yuri Cunha on 28/01/24.
//

import Foundation

enum ArtistEndpoint: Endpoint {
    case relatedArtists(String)
    case details(String)
    case topTracks(String)
    case albums(String)
    var host: String {
        SpotifyBaseURL.api.rawValue
    }
    
    var path: String {
        switch self {
        case .relatedArtists(let artistId):
            return "/v1/artists/\(artistId)/related-artists"
        case .details(let artistId):
            return "/v1/artists/\(artistId)"
        case .topTracks(let artistId):
            return "/v1/artists/\(artistId)/top-tracks"
        case .albums(let artistId):
            return "/v1/artists/\(artistId)/albums"
        }
        
    }
    
    var method: RequestMethod {
        .get
    }
    
    var header: [String : String]? {
        ["Authorization": "Bearer \(SpotifyAuthenticationManager.shared.accessToken ?? "")"]
    }
    
    var jsonBody: [String : String]? {
        nil
    }
    
    var queryItems: [URLQueryItem]? {
        nil
    }
}
                        
