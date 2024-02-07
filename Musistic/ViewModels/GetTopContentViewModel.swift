//
//  GetTopArtistsViewModel.swift
//  Musistic
//
//  Created by Yuri Cunha on 29/01/24.
//

import SwiftUI
import Observation



@Observable
final class TopContentViewModel<T> where T: ContentForRender & Codable {
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
        case .success(let content):
            self.content = content.items
        case .failure(let error):
            print(error)
        }
    }
    
    
    func prepareForRender() async {
        for item in content {
            do {
                guard let url = URL(string: item.imageUrlString!) else { return }
                let (data,_) = try await URLSession.shared.data(for: URLRequest(url: url))
                var renderItem = item
                renderItem.setValue(for: data)
                self.contentForRender.append(renderItem)
                
                
            } catch {
                print(error)
            }
        }
    }
    @MainActor
    func renderImage() async -> Image? {
        let imageRenderer = ImageRenderer(content: ShareItemView(tracks: contentForRender))
        let image = imageRenderer.uiImage
        guard let image else { return nil }
        return Image(uiImage: image)
        
    }
    
}
