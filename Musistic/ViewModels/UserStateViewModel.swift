//
//  UserStateViewModel.swift
//  Musistic
//
//  Created by Yuri Cunha on 21/01/24.
//

import Observation
import SwiftUI
@Observable
final class UserStateViewModel: GetCode {
    var isLogged: Bool = false
    var isLoading = false
    var isFinishedAuthentication = false
    
    
    func logout() {
        isLogged = false
        isLoading = false
        isFinishedAuthentication = false
    }
    
    func createUrlForAuthorization() -> URL? {
        let endpoint = AuthorizeEndpoint.authorize
        let response = createUrl(endpoint: endpoint)
        switch response {
        case .success(let url):
            return url
        case .failure(_):
            return nil
        }
    }
    
    func handleSpotify(for url: URL) {
        Task {
        
            let result = await AuthenticationService().saveAcessToken(from: url)
            switch result {
            case .success(()):
                self.isFinishedAuthentication = true
            case .failure(let error):
                print(error)
            }
            
        }
    }
    
    func verifyLogin() {
        if SpotifyAuthenticationManager.shared.isAccessTokenValid() {
            withAnimation {
                self.isLogged = true
                
            }
            
            print("tudo valendo!!!!!")
        } else {
            Task {
                if SpotifyAuthenticationManager.shared.alwaysValidAcessToken != nil {
                    let result = await AuthenticationService().refreshToken()
                    switch result {
                    case .success(let isAuthenticated):
                        self.isLogged = true
                        print("refreshing token!!!!!!!!!!!!")
                    case .failure(let error):
                        print(error)
                    }
                }
            }
        }
    }
  
}
