//
//  AuthenticationService.swift
//  Musistic
//
//  Created by Yuri Cunha on 18/01/24.
//

import Foundation

struct AuthenticationService: HTTPClient {
    
    func SaveAcessToken(from url: URL) async -> Result<Bool,RequestError> {
        
        guard let code = getAuthorizationCode(from: url) else { return .failure(.unknown) }
        let endpoint = TokenEndpoint(code: code)
        let result =  await sendRequest(endpoint: endpoint, responseModel: AccessTokenResponse.self)
        switch result {
        case .success(let accessTokenResponse):
            SpotifyAuthenticationManager.shared.saveCredentials(for: accessTokenResponse!)
            return .success(true)
            
        case .failure(let error):
            print(error)
            return .failure(.unknown)
        }
    }
    
    private func getAuthorizationCode(from url: URL) -> String? {
            let components = URLComponents(url: url, resolvingAgainstBaseURL: true)
            let code = components?.queryItems?.first(where: {$0.name == "code"})?.value
            guard let code = code else { return nil }
            return code
        }
}
