//
//  PlaylistListView.swift
//  Musistic
//
//  Created by Yuri Cunha on 15/02/24.
//

import SwiftUI

struct PlaylistListView: View {
    let viewModel: PlaylistViewModel
    init(playlist: Playlist?) {
        self.viewModel = PlaylistViewModel(playlist: playlist)
    }
    
    var body: some View {
        List {
            if viewModel.isFatchingData {
                SkeletonView()
            } else {
                ForEach(viewModel.tracks) { track in
                    Text(track.track.name)
                }
            }
        }
        .listStyle(.plain)
    }
}

#Preview {
    PlaylistListView(playlist: nil)
}
