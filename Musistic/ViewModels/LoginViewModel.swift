//
//  LoginViewModel.swift
//  Musistic
//
//  Created by Yuri Cunha on 01/02/24.
//

import Observation
import Foundation
import SwiftUI
import AuthenticationServices
@Observable
final class LoginViewModel: GetCode {
    func openDeepLink() {
        let result = createUrl(endpoint: AuthorizeEndpoint.authorize)
        switch result {
        case .success(let url):
            let webLogin = ASWebAuthenticationSession(url: url, callbackURLScheme: SpotifyBaseURL.redirectURL.rawValue
            ) { url, error in
                if error != nil {
                    print(error)
                    return
                }
                print(url)
                
            }
            webLogin.start()
        case .failure(let error):
            print(error)
        }
    }
}
