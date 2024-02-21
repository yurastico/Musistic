//
//  TopArtistDetail.swift
//  Musistic
//
//  Created by Yuri Cunha on 21/01/24.
//

import SwiftUI

struct TopArtistDetailView: View {
    let viewModel: ArtistDetailViewModel
    
    init(artistId: String) {
        self.viewModel = ArtistDetailViewModel(artistId: artistId)
    }
    
    var body: some View {
        ScrollView {
            if let artist = viewModel.artist {
                VStack {
                    ArtistPhotoView(artist: artist)
                    
                    Divider()
                    
                    ArtistAlbumsView(albuns: viewModel.albuns)
                    Divider()
                    
                    RelatedArtistsView(artists: viewModel.relatedArtists)
                    
                    
                    Divider()
                    
                    ArtistTopTracksView(tracks: viewModel.topTracks)
                }
            }
        }
        
        .onAppear {
            Task {
                await viewModel.fetchAlbuns()
                await viewModel.fetchRelatedArtists()
                await viewModel.fetchArtistTopTracks()
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
