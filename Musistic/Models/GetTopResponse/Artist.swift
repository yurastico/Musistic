//
//  Artist.swift
//  Musistic
//
//  Created by Yuri Cunha on 16/12/23.
//

import Foundation

struct Artist: Codable,Identifiable,Hashable {
    static func == (lhs: Artist, rhs: Artist) -> Bool {
        lhs.id == rhs.id
    }
    
    let externalUrls: ExternalUrls
    let followers: Followers?
    let genres: [String]?
    let href: String
    let id: String
    let images: [APIImage]?
    let name: String
    let type: ArtistType
    let uri: String
    let availableMarkets: [String]?
    var image: Data?

    
}

extension Artist: ContentForRender {
    var imageUrlString: String? {
        self.images?.first?.url
    }
    
    var title: String? {
        self.name
    }
    
    var subtitle: String? {
        "Followers: \(self.followers?.total ?? 0)"
    }
    
    
}
