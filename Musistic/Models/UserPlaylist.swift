//
//  UserPlaylist.swift
//  Musistic
//
//  Created by Yuri Cunha on 06/02/24.
//

import Foundation

struct UserPlaylist: Codable {
    let href: String?
    let limit: Int?
    let next: String?
    let offset: Int?
    let previous: String?
    let total: Int?
    let items: [Playlist]
}

struct Playlist: Codable,Identifiable,Hashable {
    static func == (lhs: Playlist, rhs: Playlist) -> Bool {
        lhs.id == rhs.id
    }
    
    let collaborative: Bool
    let description: String
    let externalUrls: ExternalUrls
    let href: String
    let id: String
    let images: [APIImage]
    let name: String
    let owner: User
    let publicFlag: Bool?
    let snapshotId: String?
    let tracks: PlaylistTracks?
    let type: String?
    let uri: String?
}



struct PlaylistTracks: Codable,Hashable {
    let href: String
    let total: Int
}
