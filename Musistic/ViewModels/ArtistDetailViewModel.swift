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

    init(artistId: String) {
        self.artist = Artist(externalUrls: ExternalUrls(spotify: ""), followers: nil, genres: nil, href: "^", id: "123", images: nil, name: "unkown", type: .artist, uri: "^", availableMarkets: nil)
        Task {
            self.artist = await fetchArtist(for: artistId) ?? self.artist
            await loadUI()
        }
        
    }
    init(artist: Artist) {
        self.artist = artist
        Task {
            await fetchArtist()
        }
    }
    
    func fetchArtist(for id: String) async -> Artist? {
        
        let artistResponse = await ArtistDataService().fetchArtist(artistId: id)
        guard let artistResponse else { return nil }
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
 
    
    func loadUI() async {
       
            await fetchAlbuns()
            await fetchRelatedArtists()
            
            await fetchArtistTopTracks()
        
    }
    
}
