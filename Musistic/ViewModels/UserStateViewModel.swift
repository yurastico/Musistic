//
//  UserStateViewModel.swift
//  Musistic
//
//  Created by Yuri Cunha on 21/01/24.
//

import Foundation
import Observation
import AuthenticationServices
import Combine
@Observable
final class UserStateViewModel: GetCode {
    var isLogged: Bool = false
    var isLoading = false
    
    
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
    
    func handleSpotify(for url: String) {
       
    }
  
}
