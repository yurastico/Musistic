//
//  ArtistsListView.swift
//  Musistic
//
//  Created by Yuri Cunha on 12/12/23.
//

import SwiftUI

struct ArtistsListView: View {
    @Binding var viewModel: TopContentViewModel<Artist>
    var body: some View {
        TopContentListView(viewModel: viewModel) { artist in
            ArtistListRowView(artist: artist)
                .navigationTitle("Top Artists")
        } destination: { artist in
            TopArtistDetailView(artistId: artist.id)
        }
        

    }
    
    
    
}


#Preview {
    Text("lul")
    //ArtistsListView()
}
