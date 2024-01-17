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
    
    var urlBody: String? {
        nil
    }
    
    var queryParams: [String:String] {
        [
            "response_type": "code",
            "client_id": SpotifyConstants.clientId.rawValue,
            "scope": SpotifyConstants.scope.rawValue,
            "redirect_uri": SpotifyBaseURL.redirectURL.rawValue,
            "state": generateRandomString()
        ]
    }
    
    private func generateRandomString(length: Int = 16) -> String {
           let characters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
           let randomString = (0..<length).map { _ in characters.randomElement()! }
           return String(randomString)
       }
}
