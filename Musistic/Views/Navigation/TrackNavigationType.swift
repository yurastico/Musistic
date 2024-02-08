//
//  NavigationType.swift
//  Musistic
//
//  Created by Yuri Cunha on 16/12/23.
//

import Foundation

enum TrackNavigationType: Hashable {
    case trackDetail(track: Track)
}

enum ArtistNavigationType: Hashable {
    case artistDetail(artist: Artist)
}

enum ContentNavigationType<T>: Hashable where T:Hashable {
    case detail(T)
}

enum PlaylistNavigationType: Hashable {
    case detail(Playlist)
}

