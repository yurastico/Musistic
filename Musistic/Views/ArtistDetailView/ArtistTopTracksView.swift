//
//  ArtistTopTracks.swift
//  Musistic
//
//  Created by Yuri Cunha on 14/02/24.
//

import SwiftUI

struct ArtistTopTracksView: View {
    let tracks: [Track]
    var body: some View {
        VStack(alignment: .leading) {
            var number = 0
            ForEach(tracks) { track in
                HStack {
                    if let url = URL(string: track.album.images.first!.url) {
                        Text("\(number.autoIncrement() - 10)")
                            .font(.caption2)
                        AsyncImageContainerView(url: url)
                            .frame(width: 50,height: 50)
                        Text(track.name)
                        
                    }
                    
                }
            }
        }
    }
}

#Preview {
    ArtistTopTracksView(tracks: [])
}
