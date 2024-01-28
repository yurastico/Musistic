//
//  TopArtistDetail.swift
//  Musistic
//
//  Created by Yuri Cunha on 21/01/24.
//

import SwiftUI

struct TopArtistDetail: View {
    var artist: Artist
    let viewModel: ArtistDetailViewModel
    init(artist: Artist) {
        self.artist = artist
        self.viewModel = ArtistDetailViewModel(artistId: artist.id)
    }
    
    var body: some View {
        ScrollView {
            VStack {
                TabView {
                    ForEach(artist.images ?? []) { image in
                        if let url = URL(string: image.url) {
                            AsyncImageContainer(url: url)
                        }
                    }
                }.tabViewStyle(.page)
                VStack {
                    Text(artist.name)
                        .font(.largeTitle)
                        .bold()
                }
                
                TabView {
                    ForEach(viewModel.albuns) { albun in
                        if let url = URL(string: albun.images.first!.url) {
                            AsyncImageContainer(url: url)
                        }
                    }
                }.tabViewStyle(.page)
                
                VStack {
                    ForEach(viewModel.relatedArtists) { artist in
                        HStack {
                            
                            
                            if let url = URL(string: artist.images!.first!.url) {
                                AsyncImageContainer(url: url)
                            }
                            Text(artist.name)
                        }
                    }
                }
                VStack {
                    ForEach(viewModel.topTracks) { track in
                        HStack {
                            
                            
                            if let url = URL(string: track.album.images.first!.url) {
                                AsyncImageContainer(url: url)
                            }
                            Text(track.name)
                        }
                    }
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
