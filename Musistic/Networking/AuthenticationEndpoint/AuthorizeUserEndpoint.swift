//
//  AuthorizeUserEndpoint.swift
//  Musistic
//
//  Created by Yuri Cunha on 16/01/24.
//

import Foundation

enum AuthorizeEndpoint {
    case authorize
}

extension AuthorizeEndpoint: Endpoint {
    var queryItems: [URLQueryItem]? {
        return [URLQueryItem(name: "response_type", value: "code"),
                URLQueryItem(name: "client_id", value: SpotifyConstants.clientId.rawValue),
                URLQueryItem(name: "scope", value: SpotifyConstants.scope.rawValue),
                URLQueryItem(name: "redirect_uri", value: SpotifyBaseURL.redirectURL.rawValue),
                URLQueryItem(name: "state", value: generateRandomString())]
    }
    
    var host: String {
        SpotifyBaseURL.auth.rawValue
    }
    
    var path: String {
        switch self {
        case .authorize:
            "/authorize"
        }
    }
    
    var method: RequestMethod {
        .get
    }
    
    var header: [String : String]? {
        nil
    }
    
    var jsonBody: [String : String]? {
        nil
    }
    
    private func generateRandomString(length: Int = 16) -> String {
           let characters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
           let randomString = (0..<length).map { _ in characters.randomElement()! }
           return String(randomString)
       }
}
