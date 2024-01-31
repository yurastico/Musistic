//
//  GetTopEndpoint.swift
//  Musistic
//
//  Created by Yuri Cunha on 21/01/24.
//

import Foundation

enum GetTopPath {
    case tracks
    case artists
    static func returnType<T: Decodable>(for type: T.Type) -> GetTopPath {
        switch type {
        case is Track.Type:
            return .tracks
        case is Artist.Type:
            return .artists
        default:
            fatalError("oops")
        }
    }
}

struct GetTopEndpoint {
    let accessToken: String
    let paths: GetTopPath
    let filterQueryItems: [URLQueryItem]?
    
    init(accessToken: String, paths: GetTopPath, queryItems: [URLQueryItem]? = nil) {
        self.accessToken = accessToken
        self.paths = paths
        self.filterQueryItems = queryItems
    }
}

extension GetTopEndpoint: Endpoint {
    var host: String {
        SpotifyBaseURL.api.rawValue
    }
    
    var path: String {
        switch paths {
        case .tracks:
            return "/v1/me/top/tracks"
        case .artists:
            return "/v1/me/top/artists"
        }
    }
    
    var method: RequestMethod {
        .get
    }
    
    var header: [String : String]? {
        ["Authorization": "Bearer \(accessToken)"]
    }
    
    var jsonBody: [String : String]? {
        nil
    }
    
    var queryItems: [URLQueryItem]? {
        self.filterQueryItems
    }
    
    
}

enum TimeRange: String, CaseIterable {
    case shortTerm = "short_term"
    case mediumTerm = "medium_term"
    case longTerm = "long_term"
}

