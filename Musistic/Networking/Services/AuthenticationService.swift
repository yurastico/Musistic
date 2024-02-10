//
//  AuthenticationService.swift
//  Musistic
//
//  Created by Yuri Cunha on 18/01/24.
//

import Foundation

struct AuthenticationService: HTTPClient {
    
    func saveAcessToken(from url: URL) async -> Result<(),RequestError> {
        guard let code = getAuthorizationCode(from: url) else { return .failure(.invalidURL)}
        let endpoint = TokenEndpoint(code: code)
        
        let result =  await sendRequest(endpoint: endpoint, responseModel: AccessTokenResponse.self)
        switch result {
        case .success(let accessTokenResponse):
            guard let accessTokenResponse else { return .failure(.noContent) }
            SpotifyAuthenticationManager.shared.saveCredentials(for: accessTokenResponse)
            return .success(())
        case .failure(let error):
            print(error.errorMessage)
        }
        return .failure(.unknown)
    }
    
    func refreshToken() async -> Result<Bool,RequestError> {
        guard let refreshToken = SpotifyAuthenticationManager.shared.refreshToken else { return .failure(.expiredToken) }
        let endpoint = RefreshTokenEndpoint(refreshToken: refreshToken)
        
        let result = await sendRequest(endpoint: endpoint, responseModel: AccessTokenResponse.self)
        switch result {
        case .success(let accessTokenResponse):
            guard let accessTokenResponse else { return .success(false)}
            SpotifyAuthenticationManager.shared.saveCredentials(for: accessTokenResponse)
            return .success(true)
        case .failure(let error):
            return .failure(error)
        }
    }
    
    private func getAuthorizationCode(from url: URL) -> String? {
        let components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        let code = components?.queryItems?.first(where: {$0.name == "code"})?.value
        guard let code = code else { return nil }
        return code
    }
}
