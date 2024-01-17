//
//  AuthenticationEndpoint.swift
//  Musistic
//
//  Created by Yuri Cunha on 16/01/24.
//

import Foundation

enum TokenEndpoint {
    case logout
    case logIn
    case refreshToken
}

extension TokenEndpoint: Endpoint {
    var urlBody: String? {
        "grant_type=authorization_code&code=\(fatalError("esqueceu de colocar o code aqui"))&redirect_uri=\(SpotifyBaseURL.redirectURL.rawValue)"
    }
    
    var host: String {
        "accounts.spotify.com/api"
    }
    
    var path: String {
        "/token"
    }
    
    var method: RequestMethod {
        .post
    }
    
    var header: [String : String]? {
        ["Content-Type" : "application/x-www-form-urlencoded"]
    }
    
    var jsonBody: [String : String]? {
        nil
    }
    
    
}
