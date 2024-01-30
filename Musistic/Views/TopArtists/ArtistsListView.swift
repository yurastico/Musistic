//
//  ArtistsListView.swift
//  Musistic
//
//  Created by Yuri Cunha on 12/12/23.
//

import SwiftUI

struct ArtistsListView: View {
    @State private var viewModel: TopArtistsViewModel<Artist> = .init()
    var body: some View {
        TopContentListView(viewModel: viewModel) { artist in
            ArtistListRow(artist: artist)
        }
    }
    
    
    
}


#Preview {
    Text("lul")
    //ArtistsListView()
}
