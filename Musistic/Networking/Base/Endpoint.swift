//
//  Endpoint.swift
//  Musistic
//
//  Created by Yuri Cunha on 15/01/24.
//

import Foundation

protocol Endpoint {
    var schema: String { get }
    var host: String { get }
    var path: String { get }
    var method: RequestMethod { get }
    var header: [String: String]? { get }
    var jsonBody: [String: String]? { get }
    var queryItems: [URLQueryItem]? { get }
    
    
}

extension Endpoint {
    var schema: String {
        "https"
    }
    
    
}
