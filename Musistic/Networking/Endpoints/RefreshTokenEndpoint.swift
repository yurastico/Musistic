//
//  RefreshTokenEndpoint.swift
//  Musistic
//
//  Created by Yuri Cunha on 20/01/24.
//

import Foundation

struct RefreshTokenEndpoint {
    var refreshToken: String
}

extension RefreshTokenEndpoint: Endpoint {
   
    var queryItems: [URLQueryItem]? {
        return [URLQueryItem(name: "grant_type", value:"refresh_token"),
                URLQueryItem(name: "refresh_token", value: refreshToken),
                URLQueryItem(name: "client_id", value: SpotifyConstants.clientId.rawValue)]
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
