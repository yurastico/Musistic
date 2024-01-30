//
//  GetTopArtistsViewModel.swift
//  Musistic
//
//  Created by Yuri Cunha on 29/01/24.
//

import SwiftUI
import Observation



@Observable
final class TopArtistsViewModel<T> where T: Codable {
    var content = [T]()
    var contentForRender = [TrackForRender]()
    
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
        let result = await GetTopService().fetchTop(for: T.self,timeRange: range)
        switch result {
        case .success(let artists):
            self.content = artists.items
        case .failure(let error):
            print(error)
        }
    }
    
    func prepareForRender() async {
        for artist in content {
//            do {
//                guard let url = URL(string: artist.images![0].url) else { return }
//                let (data,_) = try await URLSession.shared.data(for: URLRequest(url: url))
//                
//                guard let uiImage = UIImage(data: data) else { return }
//                let renderTrack = TrackForRender(id: artist.id, artist: artist.name, image: Image(uiImage: uiImage), name: artist.name, trackAlbumName: artist.genres?.first ?? "")
//                self.contentForRender.append(renderTrack)
//                
//            } catch {
//                print(error)
//            }
            
        }
    }
    @MainActor
    func renderImage() async -> Image? {
        
        let imageRenderer = ImageRenderer(content: ShareItemView(tracks: self.contentForRender))
        let image = imageRenderer.uiImage
        
        
        guard let image else {
            
            return nil }
        return Image(uiImage: image)
        
    }
    
}
