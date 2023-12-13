//
//  Model.swift
//  Musistic
//
//  Created by Yuri Cunha on 12/12/23.
//
struct BaseResponse<T>: Codable where T: Codable {
    let href: String
    let limit: Int
    let next: String?
    let offset: Int
    let previous: String?
    let total: Int
    let items: [T]
}

// MARK: - Item
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

// MARK: - Album
struct Album: Codable {
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
    
    struct APIImage: Codable {
        let url: String
        let height, width: Int
    }

}



// MARK: - Artist
struct Artist: Codable,Identifiable {
    let external_urls: ExternalUrls
    let followers: Followers?
    let genres: [String]?
    let href: String
    let id: String
    let images: [APIImage]?
    let name: String
    let type: ArtistType
    let uri: String
    
    struct APIImage: Codable {
        let url: String
        let height, width: Int
    }

   
}

struct Followers: Codable {
    let href: String?
    let total: Int
}

struct ExternalUrls: Codable {
    let spotify: String
}

enum ArtistType: String, Codable {
    case artist = "artist"
}




struct ExternalIDS: Codable {
    let isrc: String
}

enum ItemType: String, Codable {
    case track = "track"
}

