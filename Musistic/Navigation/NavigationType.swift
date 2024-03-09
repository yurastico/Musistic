//
//  NavigationType.swift
//  Musistic
//
//  Created by Yuri Cunha on 16/12/23.
//

import Foundation

enum NavigationType: Identifiable,Hashable {
    static func == (lhs: NavigationType, rhs: NavigationType) -> Bool {
        lhs.id == rhs.id
    }
    
    var id: String {
        UUID().uuidString
    }
    
    case trackDetail(track: Track)
    case artistDetail(artist: Artist)
    case artistDetailFromId(artistId: String)
    case playlistDetail(Playlist)
    case login
    case main
    case trackList
    case artistList
    case myPlaylists
}


