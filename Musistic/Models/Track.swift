//
//  Track.swift
//  Musistic
//
//  Created by Yuri Cunha on 16/12/23.
//

import Foundation

struct Track: Codable, Identifiable {
    let album: Album
    let artists: [Artist]
    let available_markets: [String]
    let disc_number: Int
    let duration_ms: Int
    let explicit: Bool
    let external_ids: ExternalIDS
    let external_urls: ExternalUrls
    let href: String
    let id: String
    let name: String
    let popularity: Int
    let preview_url: String?
    let track_number: Int
    let type: ItemType
    let uri: String
    let is_local: Bool
    
}
