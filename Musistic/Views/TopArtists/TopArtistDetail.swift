//
//  TopArtistDetail.swift
//  Musistic
//
//  Created by Yuri Cunha on 21/01/24.
//

import SwiftUI

struct TopArtistDetail: View {
    let viewModel: ArtistDetailViewModel
    
    init(artistId: String) {
        self.viewModel = ArtistDetailViewModel(artistId: artistId)
    }
    
    var body: some View {
        ScrollView {
            if let artist = viewModel.artist {
                VStack {
                    VStack(spacing: 0) {
                        if let url = URL(string: artist.images!.first!.url) {
                            AsyncImageContainer(url: url)
                                .clipShape(Circle())
                            
                            Text(artist.name)
                                .font(.largeTitle)
                                .bold()
                        }
                        
                    }
                    .frame(height: 150)
                    .frame(maxWidth: .infinity)
                    
                    
                    Divider()
                    
                    TabView {
                        ForEach(viewModel.albuns) { album in
                            if let url = URL(string: album.images.first!.url) {
                                VStack {
                                    AsyncImageContainer(url: url)
                                        .frame(maxWidth: .infinity)
                                    Text(album.name)
                                }
                                
                            }
                        }
                    }
                    
                    .frame(height: 250)
                    .frame(maxWidth: .infinity)
                    .tabViewStyle(.page(indexDisplayMode: .never))
                    
                    
                    Divider()
                    ScrollView(.horizontal) {
                        HStack {
                            ForEach(viewModel.relatedArtists) { artist in
                                VStack {
                                    if let url = URL(string: artist.images!.first!.url) {
                                        NavigationLink(value: ArtistNavigationType.artistDetail(artistId: artist.id)) {
                                            AsyncImageContainer(url: url)
                                                .clipShape(Circle())
                                                .frame(height: 100)
                                            Text(artist.name)
                                                .bold()
                                        }
                                       
                                    }
                                    
                                }
                                .navigationDestination(for: ArtistNavigationType.self, destination: { type in
                                    switch type {
                                    case .artistDetail(artistId: let string):
                                        TopArtistDetail(artistId: artist.id)
                                    
                                    }
                                })
                            }
                        }
                    }
                    
                    Divider()
                    
                    VStack(alignment: .leading) {
                        var number = 0
                        ForEach(viewModel.topTracks) { track in
                            
                            HStack {
                                if let url = URL(string: track.album.images.first!.url) {
                                    Text("\(number.autoIncrement() - 10)")
                                        .font(.caption2)
                                    AsyncImageContainer(url: url)
                                        .frame(width: 50,height: 50)
                                    Text(track.name)
                                    
                                }
                                
                            }
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


extension Int {
    mutating func autoIncrement() -> Int {
        self += 1
        return self
    }
}
