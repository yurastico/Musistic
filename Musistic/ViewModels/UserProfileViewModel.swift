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
    var currentContent: UserCurrentPlaying? = nil
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
    
    func getPlayingContent() async {
        let result = await UserService().fetchCurrentTrack()
        switch result {
        case .success(let currentContent):
            self.currentContent = currentContent
            
        case .failure(let error):
            self.errorMessage = error.errorMessage
        }
    }
    
}
