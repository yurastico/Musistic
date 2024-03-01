//
//  RelatedArtistsView.swift
//  Musistic
//
//  Created by Yuri Cunha on 14/02/24.
//

import SwiftUI

struct RelatedArtistsView: View {
    @Environment(Coordinator.self) var coordinator
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
                            .navigationDestination(for: NavigationType.self) { type in
                                coordinator.view(for: type)
                            }
                    }
                    
                }
            }
        }
    }
}

#Preview {
    RelatedArtistsView(artists: [])
}
