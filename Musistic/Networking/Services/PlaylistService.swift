//
//  PlaylistService.swift
//  Musistic
//
//  Created by Yuri Cunha on 18/02/24.
//

import Foundation

struct PlaylistService: HTTPClient  {
    func fetchPlaylist(playlistId: String) async -> Playlist? {
        let endpoint = PlaylistEndpoint.playlist(playlistId)
        let response = await sendRequest(endpoint: endpoint, responseModel: Playlist.self)
        
        switch response {
        case .failure(let error):
            print(error)
            return nil
        case .success(let playlist):
            return playlist
        }
    }
}
