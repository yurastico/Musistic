//
//  GetTopArtistsViewModel.swift
//  Musistic
//
//  Created by Yuri Cunha on 29/01/24.
//

import SwiftUI
import Observation



@Observable
final class GetTopArtistsViewModel {
    var artists = [Artist]()
    var tracksForRender = [TrackForRender]()
    
    func refreshContent(for range: TimeRange) async {
        if !SpotifyAuthenticationManager.shared.isAccessTokenValid() {
            let result = await AuthenticationService().refreshToken()
            switch result {
            case .success(let bool):
                if !bool {
                    return
                }
            case .failure(let error):
                print(error)
                return
            }
        }
        let result = await GetTopService().fetchTop(for: Artist.self,timeRange: range)
        switch result {
        case .success(let artists):
            self.artists = artists.items
        case .failure(let error):
            print(error)
        }
    }
    
    func prepareForRender() async {
        for artist in artists {
            do {
                guard let url = URL(string: artist.images![0].url) else { return }
                let (data,_) = try await URLSession.shared.data(for: URLRequest(url: url))
                
                guard let uiImage = UIImage(data: data) else { return }
                let renderTrack = TrackForRender(id: artist.id, artist: artist.name, image: Image(uiImage: uiImage), name: artist.name, trackAlbumName: artist.genres?.first ?? "")
                self.tracksForRender.append(renderTrack)
                
            } catch {
                print(error)
            }
            
        }
    }
    @MainActor
    func renderImage() async -> Image? {
        
        let imageRenderer = ImageRenderer(content: ShareItemView(tracks: self.tracksForRender))
        let image = imageRenderer.uiImage
        
        
        guard let image else {
            
            return nil }
        return Image(uiImage: image)
        
    }
    
}
