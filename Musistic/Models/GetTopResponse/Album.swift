//
//  Album.swift
//  Musistic
//
//  Created by Yuri Cunha on 16/12/23.
//

import Foundation

struct Album: Codable, Hashable,Identifiable {
    static func == (lhs: Album, rhs: Album) -> Bool {
        lhs.id == rhs.id
    }

    let albumType: String
    let totalTracks: Int
    let availableMarkets: [String]?
    let externalUrls: ExternalUrls
    let href: String
    let id: String
    let images: [APIImage]
    let name: String
    let releaseDate: String
    let releaseDatePrecision: String
    let type: String
    let uri: String
    let artists: [Artist]
}
