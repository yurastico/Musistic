//
//  GetTopViewModel.swift
//  Musistic
//
//  Created by Yuri Cunha on 22/01/24.
//

import SwiftUI
import Observation

@Observable
final class GetTopViewModel {
    var tracks = [Track]()
    var tracksForRender = [TrackForRender]()
    
    func refreshTracks(for range: TimeRange) async {
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
        let result = await GetTopService().fetchTop(for: Track.self,timeRange: range)
        switch result {
        case .success(let tracks):
            self.tracks = tracks.items
        case .failure(let error):
            print(error)
        }
    }
    
    func prepareForRender() async {
        for track in tracks {
            do {
                guard let url = URL(string: track.album.images[0].url) else { return }
                let (data,response) = try await URLSession.shared.data(for: URLRequest(url: url))
                guard let response = response as? HTTPURLResponse else { return }
                
                guard let uiImage = UIImage(data: data) else { return }
                let renderTrack = TrackForRender(id: track.id, artist: track.artists[0].name, image: Image(uiImage: uiImage), name: track.name, trackAlbumName: track.album.name)
                self.tracksForRender.append(renderTrack)
                
            } catch {
                print(error)
            }
            
        }
    }
    
}
