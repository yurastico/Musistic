//
//  HTTPClient.swift
//  Musistic
//
//  Created by Yuri Cunha on 15/01/24.
//

import Foundation

protocol HTTPClient {
    func sendRequest<T: Decodable>(endpoint: Endpoint, responseModel: T.Type?) async -> Result<T,RequestError>
}
