//
//  PlaylistViewModel.swift
//  Musistic
//
//  Created by Yuri Cunha on 15/02/24.
//

import Foundation
import Observation

@Observable
final class PlaylistViewModel {
    var tracks: [TrackFromPlaylist]
    let playlist: Playlist?
    var isFatchingData = true
    init(playlist: Playlist?) {
        self.tracks = []
        isFatchingData = true
        self.playlist = playlist
        Task {
            await self.getPlaylistTracks()
            self.isFatchingData = false
        }
        
        
    }
    
    private func getPlaylistTracks() async {
        let playlist = await PlaylistService().fetchPlaylist(playlistId: playlist?.id ?? "")
        self.tracks = playlist?.tracks?.items ?? []
        
    }
    
}
