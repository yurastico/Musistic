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
    
    init(artistId: String) {
        self.artistId = artistId
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
