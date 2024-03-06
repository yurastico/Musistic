//
//  TrackDetailView.swift
//  Musistic
//
//  Created by Yuri Cunha on 20/02/24.
//

import SwiftUI

struct TrackDetailView: View {
    @State private var viewModel: TrackDetailViewModel = .init()
    @Environment(Coordinator.self) var coordinator
    var track: Track
    var body: some View {
           VStack {
               AsyncImageContainerView(url: URL(string: track.album.images.first!.url)!)
               
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
                       
                       AsyncImageContainerView(url: url)
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

