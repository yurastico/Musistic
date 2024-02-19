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
    let limit: Int?
    let next: String?
    let offset: Int?
    let previous: String?
    let items: [TrackFromPlaylist]?
    
}

struct TrackFromPlaylist: Codable,Hashable,Identifiable {
    
    var id: String {
        self.track.id
    }
    
    static func == (lhs: TrackFromPlaylist, rhs: TrackFromPlaylist) -> Bool {
        lhs.track.id == rhs.track.id
    }
    
    
    
 
    
    struct LinkedFrom: Codable {
    }
    
    struct Restrictions: Codable {
        let reason: String
    }
    

    let addedAt: String
    let addedBy: AddedBy
    let isLocal: Bool
    let track: Track
    
    struct AddedBy: Codable,Hashable {
       
        let externalUrls: ExternalUrls
        let followers: Followers?
        let href: String
        let id: String
        let type: String
        let uri: String
    }
}
