//
//  MyPlaylistsView.swift
//  Musistic
//
//  Created by Yuri Cunha on 12/12/23.
//

import SwiftUI

struct MyPlaylistsView: View {
    @State private var viewModel = PlaylistsViewModel()
    var body: some View {
        List {
            ForEach(viewModel.playlists) { Playlist in
                Text(Playlist.name)
            }
        }
        
    }
}

#Preview {
    MyPlaylistsView()
}
