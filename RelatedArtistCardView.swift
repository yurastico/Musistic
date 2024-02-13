//
//  RelatedArtistCardView.swift
//  Musistic
//
//  Created by Yuri Cunha on 13/02/24.
//

import SwiftUI

struct RelatedArtistCardView: View {
    let artist: Artist
    var body: some View {
        VStack {
            if let url = URL(string: artist.images!.first!.url) {
                NavigationLink(value: ArtistNavigationType.artistDetail(artistId: artist.id)) {
                    AsyncImageContainer(url: url)
                        .clipShape(Circle())
                        .frame(height: 100)
                    Text(artist.name)
                        .bold()
                        
                }
                .foregroundStyle(.primary)
                
                
            }
            
        }
    }
}

#Preview {
    EmptyView()
    //RelatedArtistCardView(artist: )
}
