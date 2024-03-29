//
//  TopArtistDetail.swift
//  Musistic
//
//  Created by Yuri Cunha on 21/01/24.
//

import SwiftUI
struct TopArtistDetailView: View {
    @State var
viewModel: ArtistDetailViewModel
    
    init(artist: Artist) {
        self.viewModel = ArtistDetailViewModel(artist: artist)
    }
    init(artistId: String) {
        
        self.viewModel = ArtistDetailViewModel(artistId: artistId)
        
    }
    
    var body: some View {
        ScrollView {
            
            VStack {
                ArtistPhotoView(artist: viewModel.artist)
                
                Divider()
                
                ArtistAlbumsView(albuns: $viewModel.albuns)
                Divider()
                
                RelatedArtistsView(artists: $viewModel.relatedArtists)
                
                
                Divider()
                
                ArtistTopTracksView(tracks: $viewModel.topTracks)
                    
            }
            .navigationTitle(viewModel.artist.name)

            
        }
        .onAppear {
            Task {
                await viewModel.loadUI()
            }
        }
    }
}

//#Preview {
//    TopArtistDetail()
//}


extension Int {
    mutating func autoIncrement() -> Int {
        self += 1
        return self
    }
}
