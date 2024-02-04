//
//  UserProfileViewModel.swift
//  Musistic
//
//  Created by Yuri Cunha on 04/02/24.
//

import Foundation
import Observation

@Observable
final class UserProfileViewModel {
    var user: User? = nil
    var errorMessage = ""
    func getUserContent() async {
        let result = await UserService().fetchCurrentUser()
        switch result {
        case .success(let user):
            self.user = user
        case .failure(let error):
            self.errorMessage = error.errorMessage
        }
    }
}
