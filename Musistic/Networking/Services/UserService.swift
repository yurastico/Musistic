//
//  UserService.swift
//  Musistic
//
//  Created by Yuri Cunha on 04/02/24.
//

import Foundation

struct UserService: HTTPClient {
    func fetchCurrentUser() async -> Result<User,RequestError> {
        let endpoint = UserEndpoint.profile
        let response = await sendRequest(endpoint: endpoint, responseModel: User.self)
        switch response {
        case .success(let user):
            guard let user else { return .failure(.noContent)}
            return .success(user)
        case .failure(let error):
            return .failure(error)
        }
    }
    func fetchCurrentTrack() async -> Result<UserCurrentPlaying,RequestError> {
        let endpoint = UserEndpoint.currentTrack
        let response = await sendRequest(endpoint: endpoint, responseModel: UserCurrentPlaying.self)
        switch response {
        case .success(let currentPlaying):
            guard let currentPlaying else { return .failure(.noContent)}
            return .success(currentPlaying)
        case .failure(let error):
            return .failure(error)
        }
        
    }
    func fetchUserPlaylists() async -> Result<UserPlaylist,RequestError> {
        let endpoint = UserEndpoint.playlists
        let response = await sendRequest(endpoint: endpoint, responseModel: UserPlaylist.self)
        switch response {
        case .success(let playlists):
            guard let playlists else { return .failure(.noContent)}
            return .success(playlists)
        case .failure(let error):
            return .failure(error)
        }
    }
    
}
