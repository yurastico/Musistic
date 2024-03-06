//
//  ArtistDetailViewModel.swift
//  Musistic
//
//  Created by Yuri Cunha on 27/01/24.
//

import Foundation
import Observation
@Observable
final class ArtistDetailViewModel {
    var albuns: [Album] = []
    var artist: Artist
    var relatedArtists: [Artist] = []
    var topTracks: [Track] = []

    init(artistId: String) throws {
        var response: Artist?
        Task {
            response = await Self.fetchArtist(for: artistId)
            
        }
        guard let response else { throw RequestError.unknown}
        self.artist = response

        
    }
    init(artist: Artist) {
        self.artist = artist
        Task {
            await fetchArtist()
        }
    }
    
    static func fetchArtist(for id: String) async -> Artist? {
        let artistResponse = await ArtistDataService().fetchArtist(artistId: id)
        return artistResponse
    }
    func fetchArtist() async {
        let artistResponse = await ArtistDataService().fetchArtist(artistId: self.artist.id)
        self.artist = artistResponse ?? artist
    }

    func fetchAlbuns() async {
        let service = ArtistDataService()
        let albuns = await service.fetchArtistAlbuns(artistId: self.artist.id)
        print(artist.id)
        self.albuns = albuns ?? []
    }
    func fetchArtistTopTracks() async {
        let service = ArtistDataService()
        let topTracks = await service.fetchArtistTopTracks(artistId: self.artist.id)
        
        self.topTracks = topTracks ?? []
    }
    func fetchRelatedArtists() async {
        let service = ArtistDataService()
        let relatedArtists = await service.fetchRelatedArtists(artistId: self.artist.id)
        
        self.relatedArtists = relatedArtists ?? []
    }
    
}
