//
//  RequestError.swift
//  Musistic
//
//  Created by Yuri Cunha on 15/01/24.
//

import Foundation

enum RequestError: Error {
    case invalidURL(ApiErrorResponse?), decode(ApiErrorResponse?), noResponse(ApiErrorResponse?), expiredToken(ApiErrorResponse?), noAuthorized(ApiErrorResponse?), unknown(ApiErrorResponse?),noContent(ApiErrorResponse?)
    case custom((ApiErrorResponse?))
    
    
    var errorMessage: String {
        switch self {
        case .invalidURL:
            "the URL is invalid!"
        case .decode:
            "error to decode your response"
        case .noResponse:
            "not found"
        case .expiredToken:
            "expired authentication token, please restart your app"
        case .noAuthorized:
            "you dont have authorization for this"
        case .unknown:
            "unkown error"
        case .noContent:
            "no content fot this request"
        case .custom(let error):
            "Custom error"
        }
    }
}


