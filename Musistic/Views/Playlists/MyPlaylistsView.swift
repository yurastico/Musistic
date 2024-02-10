//
//  MyPlaylistsView.swift
//  Musistic
//
//  Created by Yuri Cunha on 12/12/23.
//

import SwiftUI

struct MyPlaylistsView: View {
    @State private var viewModel = PlaylistsViewModel()
    @State private var path = NavigationPath()
    var body: some View {
            List {
                ForEach(viewModel.playlists) { playlist in
                    NavigationLink(value: PlaylistNavigationType.detail(playlist)) {
                        HStack {
                            if let url = URL(string: playlist.images.first?.url ?? "") {
                                AsyncImageContainer(url: url)
                            }
                            Text(playlist.name)
                        }
                    }
                    
                }
            }
            .navigationDestination(for: PlaylistNavigationType.self) { type in
                switch type {
                case .detail(let playlist):
                    Text("oiii")
                }
                
            }
        
        .onAppear {
            Task {
                await viewModel.getPlaylists()
            }
        }
    }
}

#Preview {
    MyPlaylistsView()
}
