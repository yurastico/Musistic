//
//  ArtistAlbunsService.swift
//  Musistic
//
//  Created by Yuri Cunha on 25/01/24.
//

import Foundation

struct ArtistDataService: HTTPClient {
    
    func fetchRelatedArtists(artistId: String) async -> [Artist]? {
        let endpoint = ArtistEndpoint.relatedArtists(artistId)
        let result = await sendRequest(endpoint: endpoint, responseModel: RelatedArtists.self)
        switch result {
        case .success(let artists):
            guard let artists else { return nil }
            return artists.artists
        case .failure(let error):
            print(error)
            return nil
        }
    }
    
    func fetchArtistTopTracks(artistId: String) async -> [Track]? {
        let endpoint = ArtistEndpoint.topTracks(artistId)
        let result = await sendRequest(endpoint: endpoint, responseModel: ArtistTopTracks.self)
        switch result {
        case .success(let tracks):
            guard let tracks else { return nil }
            return tracks.tracks
        case .failure(let error):
            print(error)
            return nil
        }
    }
    
    func fetchArtistAlbuns(artistId: String) async -> [Album]?{

        
        let endpoint = ArtistEndpoint.albums(artistId)
        let result = await sendRequest(endpoint: endpoint, responseModel: ArtistAlbuns.self)
        switch result {
        case .success(let albuns):
            return albuns?.items
        case .failure(let error):
            print(error)
            return nil
        }
    }
}
