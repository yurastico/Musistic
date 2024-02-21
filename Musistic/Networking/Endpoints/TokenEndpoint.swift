//
//  AuthenticationEndpoint.swift
//  Musistic
//
//  Created by Yuri Cunha on 16/01/24.
//

import Foundation

struct TokenEndpoint {
    var code: String
}

extension TokenEndpoint: Endpoint {

    var queryItems: [URLQueryItem]? {
        guard let pkce = PkceManager.shared else { return nil }
        return [URLQueryItem(name: "grant_type", value: "authorization_code"),
            URLQueryItem(name: "code", value: code),
            URLQueryItem(name: "redirect_uri", value: SpotifyBaseURL.redirectURL.rawValue),
                URLQueryItem(name: "client_id", value: SpotifyConstants.clientId.rawValue),
            URLQueryItem(name: "code_verifier", value: pkce.codeVerifier)]
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
