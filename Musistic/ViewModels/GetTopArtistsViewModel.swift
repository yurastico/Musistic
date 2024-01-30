//
//  GetTopArtistsViewModel.swift
//  Musistic
//
//  Created by Yuri Cunha on 29/01/24.
//

import SwiftUI
import Observation



@Observable
final class TopArtistsViewModel<T> where T: ContentForRender & Codable {
    var content = [T]()
    var contentForRender = [T]()
    
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
            do {
                guard let url = URL(string: artist.imageUrlString!) else { return }
                let (data,_) = try await URLSession.shared.data(for: URLRequest(url: url))
                
                guard let uiImage = UIImage(data: data) else { return }
                
                self.contentForRender.append(artist)
                
            } catch {
                print(error)
            }
            
        }
    }
    @MainActor
    func renderImage() async -> Image? {
        
        let imageRenderer = ImageRenderer(content: ShareItemView(tracks: contentForRender))
        let image = imageRenderer.uiImage
        
        
        guard let image else {
            
            return nil }
        return Image(uiImage: image)
        
    }
    
}
