//
//  OpenUrl.swift
//  Musistic
//
//  Created by Yuri Cunha on 17/01/24.
//

import Foundation

protocol GetCode {
    func createUrl(endpoint: AuthorizeEndpoint) -> Result<URL,RequestError>
}
extension GetCode {
    func createUrl(endpoint: AuthorizeEndpoint) -> Result<URL,RequestError> {
        var urlComponents = URLComponents()
        urlComponents.scheme = endpoint.schema
        urlComponents.host = endpoint.host
        urlComponents.path = endpoint.path
        
        urlComponents.queryItems = endpoint.queryItems
        
        guard let url = urlComponents.url else { return .failure(.invalidURL)}
        print(url)
        return .success(url)
        
    }
    
    private func createQueryItems(from queryParams: [String: String]) -> [URLQueryItem] {
        var items: [URLQueryItem] = []
                queryParams.keys.forEach { key in
                    items.append(URLQueryItem(name: key, value: queryParams[key]))
                }
            return items
    }
}
