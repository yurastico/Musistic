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
        if endpoint.method == .post {
            if let body = urlComponents.percentEncodedQuery?.data(using: .utf8) {
                request.httpBody = body
            }
        } // passar um enum explicando se eh urlencoded or json-body,receber um data

        
    
        
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
                    let decodedResponse = try decoder.decode(responseModel, from: data)
                    return .success(decodedResponse)
                } catch(let error) {
                    print(error)
                    return .failure(.decode)
                }
               
            case 400:
               
                return .failure(.custom(decodeErrorResponse(data: data)))
            case 401:
                return .failure(.noAuthorized(decodeErrorResponse(data: data)))
            default:
                print(response.statusCode)
                return .failure(.custom(decodeErrorResponse(data: data)))
            }
        } catch {
            return .failure(.unknown)
        }
        
    }
    
    private func decodeErrorResponse(data: Data) -> ApiErrorResponse? {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let errorResponse = try? decoder.decode(ApiErrorResponse.self, from: data)
        return errorResponse
    }
    
}
