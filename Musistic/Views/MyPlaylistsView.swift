//
//  MyPlaylistsView.swift
//  Musistic
//
//  Created by Yuri Cunha on 12/12/23.
//

import SwiftUI

struct MyPlaylistsView: View {
    @State private var viewModel = PlaylistsViewModel()
    @State private var isFetchingData = false
    @Environment(Coordinator.self) var coordinator
    var body: some View {
            List {
                ForEach(viewModel.playlists) { playlist in
                    NavigationLink(value: NavigationType.playlistDetail(playlist)) {
                        if isFetchingData {
                            SkeletonView()
                        } else {
                            HStack {
                                if let url = URL(string: playlist.images.first?.url ?? "") {
                                    AsyncImageContainerView(url: url)
                                        .frame(height: 50)
                                }
                                Text(playlist.name)
                            }
                        }
                    }
                    
                }
            }
            .listStyle(.plain)
            .navigationDestination(for: NavigationType.self) { type in
                coordinator.view(for: type)
            }
        
        .onAppear {
            if viewModel.playlists.isEmpty {
                isFetchingData = true
                Task {
                    await viewModel.getPlaylists()
                    isFetchingData = false
                }
            }
        }
    }
}

#Preview {
    MyPlaylistsView()
}
