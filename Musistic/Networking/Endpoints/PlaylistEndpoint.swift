//
//  PlaylistEndpoint.swift
//  Musistic
//
//  Created by Yuri Cunha on 18/02/24.
//

import Foundation

enum PlaylistEndpoint: Endpoint {
    
    case playlist(String)
    
    var host: String {
        SpotifyBaseURL.api.rawValue
    }
    
    var path: String {
        switch self {
        case .playlist(let playlist):
            "/v1/playlists/\(playlist)"
        }
        
    }
    
    var method: RequestMethod {
        .get
    }
    
    var header: [String : String]? {
        ["Authorization": "Bearer \(SpotifyAuthenticationManager.shared.alwaysValidAcessToken ?? "")"]
    }
    
    var jsonBody: [String : String]? {
        nil
    }
    
    var queryItems: [URLQueryItem]? { nil
    }
    
    
}

