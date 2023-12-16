//
//  Album.swift
//  Musistic
//
//  Created by Yuri Cunha on 16/12/23.
//

import Foundation

struct Album: Codable,Hashable {
    static func == (lhs: Album, rhs: Album) -> Bool {
        lhs.id == rhs.id
    }
    
    let album_type: String
    let total_tracks: Int
    let available_markets: [String]
    let external_urls: ExternalUrls
    let href: String
    let id: String
    let images: [APIImage]
    let name: String
    let release_date: String
    let release_date_precision: String
    let type: String
    let uri: String
    let artists: [Artist]
}
