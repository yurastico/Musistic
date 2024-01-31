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
        return [URLQueryItem(name: "grant_type", value: "authorization_code"),
            URLQueryItem(name: "code", value: code),
            URLQueryItem(name: "redirect_uri", value: SpotifyBaseURL.redirectURL.rawValue)]
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
        guard let base64Encoded = "\(SpotifyConstants.clientId.rawValue):\(SpotifyConstants.clientSecret.rawValue)".data(using: .utf8)?.base64EncodedString() else { fatalError() }
        return ["Content-Type" : "application/x-www-form-urlencoded",
        "Authorization": "Basic \(base64Encoded)"]
    }
    
    var jsonBody: [String : String]? {
        nil
    }
    
}
