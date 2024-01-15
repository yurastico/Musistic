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
    var header: [String: Any]? { get }
    var body: [String: String]? { get }
}

extension Endpoint {
    var schema: String {
        "https"
    }
    
    var host: String {
        "api.spotify.com/v1"
    }
}
