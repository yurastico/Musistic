//
//  ArtistsListView.swift
//  Musistic
//
//  Created by Yuri Cunha on 12/12/23.
//

import SwiftUI

struct ArtistsListView: View {
    @State private var viewModel: GetTopArtistsViewModel = .init()
    var body: some View {
        TopContentListView {
            ForEach(viewModel.artists) { artist in
                ArtistListRow(artist: artist)
            }
        }
        .onAppear {
            Task {
                await viewModel.refreshTracks(for: .longTerm)
            }
        }
    }
    
    
    
}


#Preview {
    Text("lul")
    //ArtistsListView()
}
