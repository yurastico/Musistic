//
//  TopMusicDetail.swift
//  Musistic
//
//  Created by Yuri Cunha on 16/12/23.
//

import SwiftUI

struct TopMusicDetail: View {
    
    @State private var viewModel: TrackDetailViewModel = .init()
    
    
    
    let track: Track
    var body: some View {
        VStack {
            AsyncImageContainer(url: URL(string: track.album.images.first!.url)!)
            
            VStack {
                Text(track.name)
                    .font(.largeTitle)
                    .bold()
                Text(track.album.name)
                    .font(.headline)
                Text(track.artists[0].name)
                    .font(.title)
            }
            
            HStack {
                if let url = URL(string: viewModel.artist?.imageUrlString ?? "") {
                    AsyncImageContainer(url: url)
                        .clipShape(Circle())
                        .frame(height: 150)
                }
                Text(track.artistsText)
            }
            
            Spacer()
        }
        .onAppear {
            Task {
                await viewModel.getArtist(for: track)
            }
        }
    }
}

#Preview {
    Text("need to fix this!!!!!")
    //TopMusicDetail(track: <#T##Track#>)
}
