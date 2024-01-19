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
    
    var urlBody: String? {
        return "grant_type=authorization_code&code=\(code)&redirect_uri=\(SpotifyBaseURL.redirectURL.rawValue)"
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
    
    static func isAcessTokenExpired() -> Bool {
        return true
    }
}
