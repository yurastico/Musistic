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
        guard let pkce = PkceManager.shared else { return nil }
        return [URLQueryItem(name: "response_type", value: "code"),
                URLQueryItem(name: "client_id", value: SpotifyConstants.clientId.rawValue),
                URLQueryItem(name: "scope", value: SpotifyConstants.scope.rawValue),
                URLQueryItem(name: "redirect_uri", value: SpotifyBaseURL.redirectURL.rawValue),
                //URLQueryItem(name: "state", value: ),
                URLQueryItem(name: "code_challenge_method", value: "S256"),
                URLQueryItem(name: "code_challenge", value: pkce.codeChallanger)
                
        ]
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
    
    
    
}


