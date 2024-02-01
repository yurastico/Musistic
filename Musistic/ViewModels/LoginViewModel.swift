//
//  LoginViewModel.swift
//  Musistic
//
//  Created by Yuri Cunha on 01/02/24.
//

import Observation
import Foundation
import SwiftUI
@Observable
final class LoginViewModel: GetCode {
    func openDeepLink() {
        let result = createUrl(endpoint: AuthorizeEndpoint.authorize)
        switch result {
        case .success(let url):
            UIApplication.shared.open(url)
        case .failure(let error):
            print(error)
        }
    }
}
