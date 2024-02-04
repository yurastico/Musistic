//
//  UserService.swift
//  Musistic
//
//  Created by Yuri Cunha on 04/02/24.
//

import Foundation

struct UserService: HTTPClient {
    func fetchCurrentUser() async -> Result<User,RequestError> {
        let endpoint = UserEndpoint()
        let response = await sendRequest(endpoint: endpoint, responseModel: User.self)
        switch response {
        case .success(let user):
            guard let user else { return .failure(.noContent)}
            return .success(user)
        case .failure(let error):
            return .failure(error)
        }
    }
}
