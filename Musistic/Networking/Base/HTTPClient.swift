//
//  HTTPClient.swift
//  Musistic
//
//  Created by Yuri Cunha on 15/01/24.
//

import Foundation

protocol HTTPClient {
    func sendRequest<T: Decodable>(endpoint: Endpoint, responseModel: T.Type?) async -> Result<T?,RequestError>
}

extension HTTPClient {
    func sendRequest<T: Decodable>(endpoint: Endpoint, responseModel: T.Type?) async -> Result<T?,RequestError> {
        var urlComponents = URLComponents()
        urlComponents.scheme = endpoint.schema
        urlComponents.host = endpoint.host
        urlComponents.path = endpoint.path
        urlComponents.queryItems = endpoint.queryItems
        
        guard let url = urlComponents.url else  {
            return .failure(.invalidURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        request.allHTTPHeaderFields = endpoint.header
        
        if let body = endpoint.jsonBody {
            request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        }
        if let body = urlComponents.percentEncodedQuery?.data(using: .utf8) {
            request.httpBody = body
            
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let response = response as? HTTPURLResponse else {
                return .failure(.noResponse)
            }
            
            switch response.statusCode {
            case 200...299:
                guard let responseModel = responseModel else {
                    return .success(nil)
                }
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                do {
                    let decoded = try decoder.decode(responseModel.self, from: data)
                } catch {
                    print(error)
                }
                guard let decodedResponse = try? decoder.decode(responseModel, from: data) else {
                    let errorResponse = try? JSONSerialization.jsonObject(with: data) as? [String: Any]
                    print(errorResponse)
                    return .failure(.decode)
                }
                
                return .success(decodedResponse)
            case 400:
                let errorResponse = try? JSONSerialization.jsonObject(with: data) as? [String: Any]
                
                return .failure(.custom(errorResponse))
            case 401:
                return .failure(.noAuthorized)
            default:
                print(response.statusCode)
                let errorResponse = try? JSONSerialization.jsonObject(with: data) as? [String: Any]
                return .failure(.custom(errorResponse))
                
                
            }
            
        } catch {
            return .failure(.unknown)
        }
        
    }
}
