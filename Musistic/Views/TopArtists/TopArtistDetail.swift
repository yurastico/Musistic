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
            
            Spacer()
        }
        .onAppear {
            Task {
                await viewModel.fetchAlbuns()
                
            }
        }
    }
}

//#Preview {
//    TopArtistDetail()
//}
