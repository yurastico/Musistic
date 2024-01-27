//
//  ArtistAlbunsService.swift
//  Musistic
//
//  Created by Yuri Cunha on 25/01/24.
//

import Foundation

struct ArtistAlbunsService: HTTPClient {
    func fetchArtistAlbuns(artistId: String) async -> [Album]?{
        guard let accessToken = SpotifyAuthenticationManager.shared.accessToken else { return nil}
        
        let endpoint = ArtistAlbunsEndpoint(artistId: artistId,accessToken: accessToken)
        let result = await sendRequest(endpoint: endpoint, responseModel: ArtistAlbuns.self)
        switch result {
        case .success(let albuns):
            return albuns?.items
        case .failure(let error):
            
            return nil
        }
    }
}
