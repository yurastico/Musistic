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
    var tracks: [Track]
    
    init(playlist: Playlist?) {
        self.tracks = []
    }
}
