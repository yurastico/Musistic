//
//  GetTopService.swift
//  Musistic
//
//  Created by Yuri Cunha on 21/01/24.
//

import Foundation


struct GetTopService: HTTPClient {
    func fetchTop<T: Decodable>(for type: T.Type, timeRange: TimeRange) async -> Result<GetTopResponse<T>,RequestError> {
        
        guard let accessToken = SpotifyAuthenticationManager.shared.accessToken else { return .failure(.expiredToken)}
        var path: GetTopPath = .tracks
        if type.self == Artist.self {
            path = .artists
        }
        let endpoint = GetTopEndpoint(accessToken: accessToken, paths: path,queryItems: [URLQueryItem(name: "time_range", value: timeRange.rawValue)])
        
        let result = await sendRequest(endpoint: endpoint, responseModel: GetTopResponse<T>.self)
        switch result {
        case .success(let topResponse):
            guard let topResponse else { return .failure(.decode)}
            return .success(topResponse)
        case .failure(let error):
            return .failure(error)
        }
        
    }
}