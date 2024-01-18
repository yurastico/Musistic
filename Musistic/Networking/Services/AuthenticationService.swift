//
//  AuthenticationService.swift
//  Musistic
//
//  Created by Yuri Cunha on 18/01/24.
//

import Foundation

struct AuthenticationService: HTTPClient {
    
    func getAcessToken(from url: URL) async -> AccessTokenResponse? {
        
        guard let code = getAuthorizationCode(for: url) else { return nil }
        let endpoint = TokenEndpoint(code: code)
        let result =  await sendRequest(endpoint: endpoint, responseModel: AccessTokenResponse.self)
        switch result {
        case .success(let ac):
            print(ac)
            return ac
            
        case .failure(let error):
            print(error)
            return nil
        }
    }
    
    private func getAuthorizationCode(for url: URL) -> String? {
            let components = URLComponents(url: url, resolvingAgainstBaseURL: true)
            let code = components?.queryItems?.first(where: {$0.name == "code"})?.value
            guard let code = code else { return nil }
            return code
        }
}
