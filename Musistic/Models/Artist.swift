//
//  Artist.swift
//  Musistic
//
//  Created by Yuri Cunha on 16/12/23.
//

import Foundation

struct Artist: Codable,Identifiable, Hashable {
    let externalUrls: ExternalUrls
    let followers: Followers?
    let genres: [String]?
    let href: String
    let id: String
    let images: [APIImage]?
    let name: String
    let type: ArtistType
    let uri: String
}
