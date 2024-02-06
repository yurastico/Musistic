//
//  PlaylistsViewModel.swift
//  Musistic
//
//  Created by Yuri Cunha on 06/02/24.
//

import Foundation
import Observation

@Observable
final class PlaylistsViewModel {
    var playlists: [Playlist] = []
    
    func getPlaylists() async {
        let response = await UserService().fetchUserPlaylists()
        switch response {
        case .success(let playlistResponse):
            self.playlists = playlistResponse.items
        case .failure(let error):
            print(error)
        }
    }
    
}



