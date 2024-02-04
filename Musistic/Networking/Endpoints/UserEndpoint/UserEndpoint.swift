//
//  UserEndpoint.swift
//  Musistic
//
//  Created by Yuri Cunha on 04/02/24.
//

import Foundation

enum UserEndpoint: Endpoint {
    case profile,currentTrack
    var host: String {
        SpotifyBaseURL.api.rawValue
    }
    var path: String {
        switch self {
        case .profile:
            return "/v1/me"
        case .currentTrack:
            return "/v1/me/player/currently-playing"
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
