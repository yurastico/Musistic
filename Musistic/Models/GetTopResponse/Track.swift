//
//  Track.swift
//  Musistic
//
//  Created by Yuri Cunha on 16/12/23.
//

import Foundation
import SwiftUI
struct Track: Codable, Identifiable, Hashable {
    static func == (lhs: Track, rhs: Track) -> Bool {
        return lhs.id == rhs.id
    }
    
    let album: Album
    let artists: [Artist]
    let availableMarkets: [String]?
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
    var image: Data?
}

extension Track: ContentForRender {
    
    var imageUrlString: String? {
        self.album.images.first?.url
    }
    
    var title: String? {
        self.name
    }
    
    var subtitle: String? {
        self.artists.first?.name
    }
    
    
}


protocol ContentForRender: Identifiable,Hashable {
    var imageUrlString: String? { get}
    var title: String? { get }
    var subtitle: String? { get }
    //var image: Image? { get set }
    var image: Data? { get set}
}

//extension ContentForRender {
//    var image: Image? {
//        get {
//            return Image(systemName: "plus")
//            
//        } set(newImage) {
//            image = newImage
//        }
//    }
//}

extension ContentForRender {
    mutating func setValue(for data: Data) {
        self.image = data
    }
}
