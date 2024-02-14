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
        VStack(alignment: .center,spacing: 4) {
            if let url = URL(string: artist.images!.first!.url) {
                NavigationLink(value: ArtistNavigationType.artistDetail(artistId: artist.id)) {
                    VStack(alignment: .center,spacing: 4) {
                        AsyncImageContainer(url: url)
                            .scaledToFill()
                            .frame(width:150,height: 150)
                            .clipShape(Circle())
                            
                            
                        Text(artist.name)
                            .multilineTextAlignment(.center)
                            .lineLimit(1)
                            .bold()
                            .frame(width: 150)
                            
                    }
                }
                .foregroundStyle(.primary)
                
                
            }
            
        }
        .padding()
        
    }
}

#Preview {
    EmptyView()
    //RelatedArtistCardView(artist: )
}
