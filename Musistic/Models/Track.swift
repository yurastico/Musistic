//
//  Track.swift
//  Musistic
//
//  Created by Yuri Cunha on 16/12/23.
//

import Foundation

struct Track: Codable, Identifiable, Hashable {
    static func == (lhs: Track, rhs: Track) -> Bool {
        return lhs.id == rhs.id
    }
    
    let album: Album
    let artists: [Artist]
    let availableMarkets: [String]
    let discNumber: Int
    let durationMs: Int
    let explicit: Bool
    let externalIds: ExternalIDS
    let externalUrls: ExternalUrls
    let href: String
    let id: String
    let name: String
    let popularity: Int
    let previewUrl: String?
    let trackNumber: Int
    let type: ItemType
    let uri: String
    let isLocal: Bool
    
}
