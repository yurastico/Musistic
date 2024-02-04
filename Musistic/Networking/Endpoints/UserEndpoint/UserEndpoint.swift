//
//  UserEndpoint.swift
//  Musistic
//
//  Created by Yuri Cunha on 04/02/24.
//

import Foundation

struct UserEndpoint: Endpoint {
    var host: String {
        SpotifyBaseURL.api.rawValue
    }
    var path: String {
        "/v1/me"
    }
    
    var method: RequestMethod {
        .get
    }
    
    var header: [String : String]? {
        ["Authorization": "Bearer \(accessToken ?? "")"]
    }
    
    var jsonBody: [String : String]?
    
    var queryItems: [URLQueryItem]?
    
    var accessToken: String? {
        SpotifyAuthenticationManager.shared.accessToken
    }
    
}
