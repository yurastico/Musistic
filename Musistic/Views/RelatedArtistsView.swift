//
//  RelatedArtistsView.swift
//  Musistic
//
//  Created by Yuri Cunha on 14/02/24.
//

import SwiftUI

struct RelatedArtistsView: View {
    let artists: [Artist]
    var body: some View {
        VStack(alignment: .leading) {
            Text("Related Artists")
                .font(.largeTitle)
                .fontWeight(.bold)
            ScrollView(.horizontal,showsIndicators: false) {
                HStack {
                    ForEach(artists) { artist in
                        RelatedArtistCardView(artist: artist)
                        .navigationDestination(for: ArtistNavigationType.self, destination: { type in
                            switch type {
                            case .artistDetail(artistId: let id):
                                TopArtistDetailView(artistId: id)
                                
                            }
                        })
                    }
                    
                }
            }
        }
    }
}

#Preview {
    RelatedArtistsView(artists: [])
}
