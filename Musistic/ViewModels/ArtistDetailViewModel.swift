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
    let artistId: String
    var relatedArtists: [Artist] = []
    var topTracks: [Track] = []
    var artist: Artist?
    
    init(artistId: String) {
        self.artistId = artistId
        if !SpotifyAuthenticationManager.shared.isAccessTokenValid() {
            Task {
                _ = await AuthenticationService().refreshToken()
                
            }
        }
        Task {
            await fetchArtist()
        }
    }
    
    func fetchArtist() async {
        let artistResponse = await ArtistDataService().fetchArtist(artistId: self.artistId)
        self.artist = artistResponse
    }

    func fetchAlbuns() async {
        let service = ArtistDataService()
        let albuns = await service.fetchArtistAlbuns(artistId: self.artistId)
        
        self.albuns = albuns ?? []
    }
    func fetchArtistTopTracks() async {
        let service = ArtistDataService()
        let topTracks = await service.fetchArtistTopTracks(artistId: self.artistId)
        
        self.topTracks = topTracks ?? []
    }
    func fetchRelatedArtists() async {
        let service = ArtistDataService()
        let relatedArtists = await service.fetchRelatedArtists(artistId: self.artistId)
        
        self.relatedArtists = relatedArtists ?? []
    }
    
}
