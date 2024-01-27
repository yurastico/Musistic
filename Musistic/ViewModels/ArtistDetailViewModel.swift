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
    
    init(artistId: String) {
        self.artistId = artistId
    }
    
    func fetchAlbuns() async {
        let service = ArtistAlbunsService()
        let albuns = await service.fetchArtistAlbuns(artistId: self.artistId)
        print(albuns)
        self.albuns = albuns ?? []
    }
    
    
}
