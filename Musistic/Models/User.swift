//
//  User.swift
//  Musistic
//
//  Created by Yuri Cunha on 04/02/24.
//

import Foundation
struct User: Codable {
    let country: String?
    let displayName: String?
    let email: String?
    let explicitContent: ExplicitContent?
    let externalUrls: ExternalUrls?
    let followers: Followers?
    let href: String?
    let id: String
    let images: [APIImage]?
    let product: String?
    let type: String?
    let uri: String?
    
}

struct ExplicitContent: Codable {
    let filterEnabled: Bool
    let filterLocked: Bool
}
