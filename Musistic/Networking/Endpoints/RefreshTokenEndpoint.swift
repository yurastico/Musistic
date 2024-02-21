//
//  RefreshTokenEndpoint.swift
//  Musistic
//
//  Created by Yuri Cunha on 20/01/24.
//

import Foundation


enum RefreshTokenEndpoint: Endpoint {
    
    case refreshToken(String)
   
    var queryItems: [URLQueryItem]? {
        switch self {
        case .refreshToken(let token):
            return [URLQueryItem(name: "grant_type", value:"refresh_token"),
                    URLQueryItem(name: "refresh_token", value: token),
                    URLQueryItem(name: "client_id", value: SpotifyConstants.clientId.rawValue)]
        }

    }
    
    var host: String {
        SpotifyBaseURL.auth.rawValue
    }
    
    var path: String {
        "/api/token"
    }
    
    var method: RequestMethod {
        .post
    }
    
    var header: [String : String]? {
        return ["Content-Type" : "application/x-www-form-urlencoded"]
    }
    
    var jsonBody: [String : String]? {
        nil
    }
    

}
