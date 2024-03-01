//
//  Coordinator.swift
//  Musistic
//
//  Created by Yuri Cunha on 29/02/24.
//

import Observation
import SwiftUI

@Observable
final class Coordinator {
    var path: NavigationPath = .init()
    private let loginViewModel = UserStateViewModel()
    
    func pop() {
        path.removeLast()
    }

    func popToRoot() {
        //Observação (testar)
        path.removeLast(path.count)
    }

    func push(to navigationType: NavigationType) {
        path.append(navigationType)
    }

    @ViewBuilder
    func view(for navigationType: NavigationType) -> some View {
        switch navigationType {
        case .login:
            LogInView()
        case .main:
            MainView()
        case .artistDetail(artistId: let id):
            TopArtistDetailView(artistId: id)
        case .trackDetail(track: let track):
            TrackDetailView(track: track)
        case .playlistDetail(let playlist):
            PlaylistListView(playlist: playlist)
        case .trackList:
            TracksListView()
        case .artistList:
            ArtistsListView()
        }
    }
}
