//
//  ArtistsAlbuns.swift
//  Musistic
//
//  Created by Yuri Cunha on 25/01/24.
//

import Foundation

struct ArtistAlbuns: Codable {
    let href: String
    let limit: Int
    let next: String?
    let offset: Int
    let previous: String?
    let total: Int
    let items: [Album]
}
